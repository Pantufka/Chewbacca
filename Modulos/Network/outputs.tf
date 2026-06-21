output "vpc_id" {
  description = "ID de la VPC."
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR de la VPC."
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs de las subredes públicas."
  value       = aws_subnet.public[*].id
}

output "app_subnet_ids" {
  description = "IDs de las subredes de aplicación."
  value       = aws_subnet.app[*].id
}

output "db_subnet_ids" {
  description = "IDs de las subredes de base de datos."
  value       = aws_subnet.db[*].id
}