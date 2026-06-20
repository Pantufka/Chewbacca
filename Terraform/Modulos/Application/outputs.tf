output "autoscaling_group_name" {
  description = "Nombre del ASG de la aplicación."
  value       = aws_autoscaling_group.app.name
}

output "autoscaling_group_arn" {
  description = "ARN del ASG de la aplicación."
  value       = aws_autoscaling_group.app.arn
}

output "launch_template_id" {
  description = "ID del LT utilizado por el ASG."
  value       = aws_launch_template.app.id
}