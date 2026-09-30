resource "aws_sns_topic" "alerts" {
  name = "${var.environment}-cloud-webapp-alerts"

  tags = {
    Name = "${var.environment}-cloud-webapp-alerts"
  }
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.environment}-cloud-webapp-high-cpu"
  alarm_description   = "Triggers when average CPU usage is high."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 70

  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
}

resource "aws_cloudwatch_metric_alarm" "unhealthy_targets" {
  alarm_name          = "${var.environment}-cloud-webapp-unhealthy-targets"
  alarm_description   = "Triggers when the load balancer has unhealthy application targets."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 0

  dimensions = {
    TargetGroup  = var.target_group_arn_suffix
    LoadBalancer = var.load_balancer_arn_suffix
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
}