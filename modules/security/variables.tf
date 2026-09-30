variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where security groups will be created."
  type        = string
}

variable "app_port" {
  description = "Port used by the application servers."
  type        = number
  default     = 80
}

variable "db_port" {
  description = "Port used by the database."
  type        = number
  default     = 3306
}
