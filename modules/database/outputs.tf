output "database_endpoint" {
  description = "Endpoint of the RDS database."
  value       = aws_db_instance.this.address
}

output "database_port" {
  description = "Port used by the RDS database."
  value       = aws_db_instance.this.port
}

output "database_arn" {
  description = "ARN of the RDS database."
  value       = aws_db_instance.this.arn
}