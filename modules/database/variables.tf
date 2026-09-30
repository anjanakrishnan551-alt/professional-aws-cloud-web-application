variable "environment" {
  description = "Environment name."
  type        = string
}

variable "database_subnet_ids" {
  description = "Private database subnet IDs used by Amazon RDS."
  type        = list(string)
}

variable "database_security_group_id" {
  description = "Security group ID attached to the RDS database."
  type        = string
}

variable "db_name" {
  description = "Initial database name."
  type        = string
  default     = "cloudwebapp"
}

variable "db_username" {
  description = "Master database username."
  type        = string
  default     = "adminuser"
}

variable "db_instance_class" {
  description = "RDS instance type."
  type        = string
  default     = "db.t3.micro"
}