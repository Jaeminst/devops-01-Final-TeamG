resource "aws_autoscaling_policy" "notify" {
  name                   = "Target-Tracking-Policy"
  autoscaling_group_name = aws_autoscaling_group.notify.name
  policy_type            = "TargetTrackingScaling"
  adjustment_type        = ""
  scaling_adjustment     = 0
  cooldown               = 0
  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${aws_alb.notify_server.arn_suffix}/${aws_lb_target_group.notify_server.arn_suffix}"
    }
    target_value = 50
  }
}

resource "aws_autoscaling_policy" "notify-scale-in" {
  name                   = "Scale-in-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.notify.name
}

resource "aws_autoscaling_policy" "notify-scale-out" {
  name                   = "Scale-out-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.notify.name
}
