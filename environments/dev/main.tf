module "networking" {
  source = "../../modules/networking"

  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}
module "security" {
  source = "../../modules/security"

  environment = var.environment
  vpc_id      = module.networking.vpc_id
}
module "load_balancer" {
  source = "../../modules/load-balancer"

  environment           = var.environment
  vpc_id                = module.networking.vpc_id
  public_subnet_ids     = module.networking.public_subnet_ids
  alb_security_group_id = module.security.alb_security_group_id
}
module "database" {
  source = "../../modules/database"

  environment                = var.environment
  database_subnet_ids        = module.networking.database_subnet_ids
  database_security_group_id = module.security.database_security_group_id
}