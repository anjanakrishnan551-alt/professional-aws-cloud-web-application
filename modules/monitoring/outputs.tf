output "sns_topic_arn" {
  description = "ARN of the SNS topic used for monitoring alerts."
  value       = aws_sns_topic.alerts.arn
}