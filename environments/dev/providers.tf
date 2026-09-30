provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "ha-aws-three-tier"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}