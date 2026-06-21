resource "aws_security_group" "alb" {
  name        = "Chewbacca-ALB-SG"
  description = "Permite trafico HTTP y HTTPS desde Internet."
  vpc_id      = var.vpc_id
  ingress {
    description = "HTTP"
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  ingress {
    description = "HTTPS"
    from_port = 443
    to_port   = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name = "Chewbacca-ALB-SG"
  }
}

resource "aws_security_group" "app" {
  name        = "Chewbacca-APP-SG"
  description = "Permite trafico desde el Load Balancer."
  vpc_id      = var.vpc_id
  ingress {
    description = "HTTP desde ALB"
    from_port = 80
    to_port   = 80
    protocol = "tcp"
    security_groups = [
      aws_security_group.alb.id
    ]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name = "Chewbacca-APP-SG"
  }
}

resource "aws_security_group" "db" {
  name        = "Chewbacca-DB-SG"
  description = "Permite conexiones desde los servidores de aplicacion."
  vpc_id      = var.vpc_id
  ingress {
    description = "MySQL desde APP"
    from_port = 3306
    to_port   = 3306
    protocol = "tcp"
    security_groups = [
      aws_security_group.app.id
    ]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name = "Chewbacca-DB-SG"
  }
}