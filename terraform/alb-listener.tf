data "aws_acm_certificate" "jaemin" {
  domain    = "jaemin.click"
  key_types = ["RSA_2048"]
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_alb.api_server.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.jaemin.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.reserv_api_server.arn
  }
}

resource "aws_lb_listener" "api_server" {
  load_balancer_arn = aws_alb.api_server.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "redirect"
  
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "dev" {
  load_balancer_arn = aws_alb.api_server.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dev.arn
  }
}