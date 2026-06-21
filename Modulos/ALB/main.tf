resource "aws_lb" "main" {
  name               = "Chewbacca-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    var.alb_sg_id
  ]
  subnets = var.public_subnet_ids
  enable_deletion_protection = false
  tags = {
    Name = "Chewbacca-ALB"
  }
}

resource "aws_lb_target_group" "app" {
  name = "Chewbacca-TG"
  port = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id = var.vpc_id
  health_check {
    enabled = true
    protocol = "HTTP"
    path = "/"
    matcher = "200"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
  tags = {
    Name = "Chewbacca-TG"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}