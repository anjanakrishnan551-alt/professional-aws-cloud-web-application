variable "aws_region" {
  description = "AWS region for the infrastructure."
  type        = string
  default     = "eu-west-2"
}

variable "environment" {
  description = "Environment name."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR range for the VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "availability_zones" {
  description = "Availability Zones used by the infrastructure."
  type        = list(string)

  default = [
    "eu-west-2a",
    "eu-west-2b"
  ]
}