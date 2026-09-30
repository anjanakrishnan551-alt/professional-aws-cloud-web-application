output "ec2_instance_profile_name" {
  description = "Name of the IAM instance profile used by EC2."
  value       = aws_iam_instance_profile.ec2.name
}

output "ec2_role_name" {
  description = "Name of the IAM role attached to EC2."
  value       = aws_iam_role.ec2.name
}