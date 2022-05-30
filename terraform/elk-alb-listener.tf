resource "aws_lb_listener" "elk_server" {
  load_balancer_arn = aws_alb.elk_server.arn
  port              = 9200
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.elastic_server.arn
  }
}