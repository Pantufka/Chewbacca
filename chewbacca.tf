module "network" {
  source = "./Modulos/Network"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets     = var.public_subnets
  app_subnets        = var.app_subnets
  db_subnets         = var.db_subnets
}

module "security" {
  source = "./Modulos/Security"
  vpc_id = module.network.vpc_id
}

module "alb" {
  source = "./Modulos/ALB"
  vpc_id            = module.network.vpc_id
  public_subnet_ids = module.network.public_subnet_ids
  alb_sg_id = module.security.alb_sg_id
}

module "application" {
  source = "./Modulos/Application"
  app_subnet_ids = module.network.app_subnet_ids
  app_sg_id      = module.security.app_sg_id
  target_group_arn = module.alb.target_group_arn
  instance_type = var.instance_type
}

module "database" {
  source = "./Modulos/Database"
  db_subnet_ids = module.network.db_subnet_ids
  db_sg_id      = module.security.db_sg_id
  db_instance_class = var.db_instance_class
  db_username       = var.db_username
  db_password       = var.db_password
}