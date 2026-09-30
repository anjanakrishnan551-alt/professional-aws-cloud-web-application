variable "environment" {
  description = "Environment name."
  type        = string
}

variable "app_subnet_ids" {
  description = "Private application subnet IDs used by the Auto Scaling Group."
  type        = list(string)
}

variable "app_security_group_id" {
  description = "Security group ID attached to the application servers."
  type        = string
}

variable "target_group_arn" {
  description = "Target group ARN used by the Application Load Balancer."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used by the application servers."
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum number of EC2 instances."
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of EC2 instances."
  type        = number
  default     = 4
}

variable "desired_capacity" {
  description = "Desired number of EC2 instances."
  type        = number
  default     = 2
}
