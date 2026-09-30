output "load_balancer_arn" {
  description = "ARN of the Application Load Balancer."
  value       = aws_lb.this.arn
}

output "load_balancer_dns_name" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "ARN of the application target group."
  value       = aws_lb_target_group.app.arn
}
output "load_balancer_arn_suffix" {
  description = "ARN suffix of the Application Load Balancer."
  value       = aws_lb.this.arn_suffix
}

output "target_group_arn_suffix" {
  description = "ARN suffix of the target group."
  value       = aws_lb_target_group.app.arn_suffix
}