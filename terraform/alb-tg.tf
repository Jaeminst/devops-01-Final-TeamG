resource "aws_lb_target_group" "reserv_api_server" {
  name_prefix       = "server"
  port              = var.server_port
  protocol          = "HTTP"
  protocol_version  = "HTTP1"
  target_type       = "instance"
  vpc_id            = aws_vpc.project-vpc.id

  health_check {
    enabled         = true
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    matcher = 200
    path = "/index.html"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 5
  }
}