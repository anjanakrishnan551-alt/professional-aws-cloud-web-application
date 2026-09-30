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

module "iam" {
  source = "../../modules/iam"

  environment = var.environment
}

module "compute" {
  source = "../../modules/compute"

  environment               = var.environment
  app_subnet_ids            = module.networking.app_subnet_ids
  app_security_group_id     = module.security.app_security_group_id
  target_group_arn          = module.load_balancer.target_group_arn
  iam_instance_profile_name = module.iam.ec2_instance_profile_name
}
module "monitoring" {
  source = "../../modules/monitoring"

  environment              = var.environment
  autoscaling_group_name   = module.compute.autoscaling_group_name
  target_group_arn_suffix  = module.load_balancer.target_group_arn_suffix
  load_balancer_arn_suffix = module.load_balancer.load_balancer_arn_suffix
}