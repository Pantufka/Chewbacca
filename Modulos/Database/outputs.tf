output "db_instance_endpoint" {
  description = "Endpoint de conexión de la RDS."
  value       = aws_db_instance.main.endpoint
}

output "db_instance_address" {
  description = "DNS de la RDS."
  value       = aws_db_instance.main.address
}

output "db_instance_port" {
  description = "Puerto de conexión de la RDS."
  value       = aws_db_instance.main.port
}

output "db_instance_id" {
  description = "Identificador de la RDS."
  value       = aws_db_instance.main.id
}

output "db_subnet_group_name" {
  description = "Nombre del DB Subnet Group utilizado por RDS."
  value       = aws_db_subnet_group.main.name
}