variable "vpc_cidr" {
  description = "CIDR de la VPC."
  type        = string
}

variable "availability_zones" {
  description = "Lista de Availability Zones."
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Se necesitan exactamente dos Availability Zones."
  }
}

variable "public_subnets" {
  description = "Lista de CIDRs para las subredes públicas."
  type        = list(string)

  validation {
    condition     = length(var.public_subnets) == 2
    error_message = "Se necesitan exactamente dos subredes públicas."
  }
}

variable "app_subnets" {
  description = "Lista de CIDRs para las subredes de aplicación."
  type        = list(string)

  validation {
    condition     = length(var.app_subnets) == 2
    error_message = "Se necesitan exactamente dos subredes de aplicación."
  }
}

variable "db_subnets" {
  description = "Lista de CIDRs para las subredes de base de datos."
  type        = list(string)

  validation {
    condition     = length(var.db_subnets) == 2
    error_message = "Se necesitan exactamente dos subredes de base de datos."
  }
}