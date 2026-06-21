output "alb_sg_id" {
  description = "ID del SG asociado al ALB."
  value       = aws_security_group.alb.id
}

output "app_sg_id" {
  description = "ID del SG asociado a los servidores de aplicación."
  value       = aws_security_group.app.id
}

output "db_sg_id" {
  description = "ID del SG asociado a la base de datos."
  value       = aws_security_group.db.id
}