provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "professional-aws-cloud-web-application"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}