variable "environment" {
  description = "Environment name."
  type        = string
}

variable "autoscaling_group_name" {
  description = "Name of the application Auto Scaling Group."
  type        = string
}

variable "target_group_arn_suffix" {
  description = "ARN suffix of the Application Load Balancer target group."
  type        = string
}

variable "load_balancer_arn_suffix" {
  description = "ARN suffix of the Application Load Balancer."
  type        = string
}