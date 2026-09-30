variable "environment" {
  description = "Environment name."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the load balancer will be created."
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs used by the load balancer."
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID for the Application Load Balancer."
  type        = string
}

variable "app_port" {
  description = "Port used by the application servers."
  type        = number
  default     = 80
}
