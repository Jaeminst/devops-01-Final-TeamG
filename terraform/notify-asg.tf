resource "aws_autoscaling_group" "notify" {

  name = "notify-server-auto-group"

  vpc_zone_identifier = [aws_subnet.public1.id, aws_subnet.public2.id]

  target_group_arns = [
    aws_lb_target_group.notify_server.arn,
    aws_lb_target_group.notify_dev.arn
  ]

  health_check_type         = "EC2"
  health_check_grace_period = 300

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 3

  launch_template {
    id      = aws_launch_template.notify.id
    version = "$Latest"
  }
  
  lifecycle { 
    create_before_destroy = true 
  }

  tag {
    key   = "Name"
    value = "notify-server"
    propagate_at_launch = true
  }

  enabled_metrics = [
    "GroupAndWarmPoolDesiredCapacity",
    "GroupAndWarmPoolTotalCapacity",
    "GroupInServiceCapacity",
    "GroupPendingCapacity",
    "GroupPendingInstances",
    "GroupStandbyCapacity",
    "GroupStandbyInstances",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
    "WarmPoolDesiredCapacity",
    "WarmPoolMinSize",
    "WarmPoolPendingCapacity",
    "WarmPoolTerminatingCapacity",
    "WarmPoolTotalCapacity",
    "WarmPoolWarmedCapacity",
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"

}
