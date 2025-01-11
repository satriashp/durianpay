output "cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.cpu_alarm.alarm_name
}

output "status_check_alarm_name" {
  value = aws_cloudwatch_metric_alarm.status_check.alarm_name
}

output "network_in_alarm_name" {
  value = aws_cloudwatch_metric_alarm.network_in.alarm_name
}
