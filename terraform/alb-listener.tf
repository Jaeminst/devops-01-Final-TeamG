resource "aws_lb_listener" "api_server" {
  load_balancer_arn = aws_alb.api_server.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.reserv_api_server.arn
  }
}