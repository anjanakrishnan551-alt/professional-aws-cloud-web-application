output "vpc_id" {
  description = "VPC ID for the dev environment."
  value       = module.networking.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs for the dev environment."
  value       = module.networking.public_subnet_ids
}

output "app_subnet_ids" {
  description = "Private application subnet IDs for the dev environment."
  value       = module.networking.app_subnet_ids
}

output "database_subnet_ids" {
  description = "Private database subnet IDs for the dev environment."
  value       = module.networking.database_subnet_ids
}
