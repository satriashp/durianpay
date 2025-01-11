terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.83.1"
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "cpu-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
  alarm_description = "Alarm when CPU utilization >= 80%"
}

# You can add more CloudWatch alarms for memory, network, status check, etc.

resource "aws_cloudwatch_metric_alarm" "status_check" {
  alarm_name          = "status-check-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "0"
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
  alarm_description = "Alarm when Status Check Failed on an Instance"
}

resource "aws_cloudwatch_metric_alarm" "network_in" {
  alarm_name          = "network-in-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "NetworkIn"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "1000000"
  dimensions = {
    AutoScalingGroupName = var.autoscaling_group_name
  }
  alarm_description = "Alarm when Network In Greater than 1MB"
}
