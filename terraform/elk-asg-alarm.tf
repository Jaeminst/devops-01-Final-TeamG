resource "aws_cloudwatch_metric_alarm" "elk-scale-in" {
  alarm_name          = "terraform-elk-Scale-in"
  comparison_operator = "LessThanOrEqualToThreshold"
  datapoints_to_alarm = 1
  evaluation_periods  = 1
  extended_statistic  = "p95"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  threshold           = 40
  treat_missing_data  = "ignore"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.elk.name
  }

  alarm_description = "Autoscling EC2 CPU Scale-in <= 40% (p95)"
  actions_enabled   = true
  alarm_actions     = [
    aws_autoscaling_policy.elk-scale-in.arn
    #sns 추가할것
  ]
}

resource "aws_cloudwatch_metric_alarm" "elk-scale-out" {
  alarm_name          = "terraform-elk-Scale-out"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  datapoints_to_alarm = 1
  evaluation_periods  = 1
  extended_statistic  = "p95"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  threshold           = 50
  treat_missing_data  = "missing"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.elk.name
  }

  alarm_description = "Autoscling EC2 CPU Scale-out >= 50% (p95)"
  actions_enabled   = true
  alarm_actions     = [
    aws_autoscaling_policy.elk-scale-out.arn
    #sns 추가할것
  ]
}