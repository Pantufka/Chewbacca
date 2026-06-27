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

    # Instalar Apache y Git
    yum install -y httpd git

    # Habilitar Apache al iniciar la instancia
    systemctl enable httpd

    # Iniciar Apache
    systemctl start httpd

    # Clonar la aplicación
    git clone https://github.com/ORT-FI-7417-SolucionesCloud/php-ecommerce-obligatorio.git

    # Copiar la aplicación al DocumentRoot de Apache
    cp -r php-ecommerce-obligatorio/* /var/www/html/

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