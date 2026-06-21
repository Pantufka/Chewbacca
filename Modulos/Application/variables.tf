variable "app_subnet_ids" {
  description = "Lista de IDs de las subnets de aplicación donde se despliegan las EC2."
  type        = list(string)
}

variable "app_sg_id" {
  description = "ID del SG asociado a los servidores de la aplicación."
  type        = string
}

variable "target_group_arn" {
  description = "ARN del TG donde se registrarán las EC2 del ASG."
  type        = string
}

variable "instance_type" {
  description = "Tipo de instancia EC2 a utilizar."
  type        = string
}