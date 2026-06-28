data "aws_ssm_parameter" "amazon_linux_2" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_launch_template" "app" {
  name_prefix = "Chewbacca-App"
  image_id = data.aws_ssm_parameter.amazon_linux_2.value
  instance_type = var.instance_type
  vpc_security_group_ids = [
    var.app_sg_id
  ]
  iam_instance_profile {
    name = var.instance_profile_name
  }
  tags = {
    Name = "Chewbacca-App"
  }
  user_data = base64encode(<<-EOF
    #!/bin/bash

    # Actualizar los paquetes del sistema
    yum update -y

    # Habilitar el repositorio EPEL
    amazon-linux-extras enable epel

    # Instalar el paquete epel-release
    yum install -y epel-release

    # Agregar el repositorio REMI
    yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm

    # Habilitar PHP 5.4 desde REMI
    yum-config-manager --enable remi-php54

    # Instalar PHP y sus extensiones
    yum install php php-cli php-common php-mbstring php-xml php-mysql php-fpm

    # Instalar Apache, Git y MySQL
    yum install -y httpd git mysql

    # Habilitar Apache al iniciar la instancia
    systemctl enable httpd

    # Iniciar Apache
    systemctl start httpd

    # Clonar la aplicación
    git clone https://github.com/ORT-FI-7417-SolucionesCloud/php-ecommerce-obligatorio.git

    # Copiar la aplicación al DocumentRoot de Apache
    cp -r php-ecommerce-obligatorio/* /var/www/html/

    # Crear el archivo de configuración de la aplicación
    cat > /var/www/html/config.php <<EOL
    <?php
    ini_set('display_errors',1);
    error_reporting(-1);
    define('DB_HOST', '${var.db_endpoint}');
    define('DB_USER', '${var.db_username}');
    define('DB_PASSWORD', '${var.db_password}');
    define('DB_DATABASE', '${var.db_name}');
    ?>
    EOL

    # Esperar hasta que la base de datos esté disponible
    until mysqladmin ping \
    -h ${var.db_endpoint} \
    -u ${var.db_username} \
    -p${var.db_password} \
    --silent
    do
      echo "Esperando a que RDS esté disponible"
      sleep 30
    done

    # Importar la base de datos inicial
    mysql -h ${var.db_endpoint} -u ${var.db_username} -p${var.db_password} ${var.db_name} < /var/www/html/dump.sql

    # Reiniciar Apache
    systemctl restart httpd

  EOF
  )
}

resource "aws_autoscaling_group" "app" {
  name = "Chewbacca-ASG"
  desired_capacity = 2
  min_size = 2
  max_size = 4
  vpc_zone_identifier = var.app_subnet_ids
  target_group_arns = [
    var.target_group_arn
  ]
  launch_template {
    id = aws_launch_template.app.id
    version = "$Latest"
  }
  health_check_type = "ELB"
  health_check_grace_period = 300
  tag {
    key = "Name"
    value = "Chewbacca-App"
    propagate_at_launch = true
  }
}