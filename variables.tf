variable "aws_region" {
  description = "Región de AWS"
  type        = string
}

variable "aws_region" {
  description = "Región de AWS."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR de la VPC."
  type        = string
}

variable "availability_zones" {
  description = "Lista de AZs."
  type        = list(string)
}

variable "public_subnets" {
  description = "Lista de CIDRs para las subredes públicas."
  type        = list(string)
}

variable "app_subnets" {
  description = "Lista de CIDRs para las subredes de aplicación."
  type        = list(string)
}

variable "db_subnets" {
  description = "Lista de CIDRs para las subredes de base de datos."
  type        = list(string)
}

variable "instance_type" {
  description = "Tipo de instancia EC2."
  type        = string
}

variable "db_instance_class" {
  description = "Clase de instancia de RDS."
  type        = string
}

variable "db_username" {
  description = "Usuario admin de la base de datos."
  type        = string
}

variable "db_password" {
  description = "Contraseña del usuario admin de la base de datos."
  type        = string
  sensitive   = true
}