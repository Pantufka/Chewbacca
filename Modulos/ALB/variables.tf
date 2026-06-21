variable "vpc_id" {
  description = "ID de la VPC donde se despliega el ALB."
  type        = string
}

variable "public_subnet_ids" {
  description = "Lista de IDs de las subredes públicas donde se despliega el ALB."
  type        = list(string)
}

variable "alb_sg_id" {
  description = "ID del SG asociado al ALB."
  type        = string
}