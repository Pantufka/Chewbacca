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