resource "aws_lb_target_group" "elastic_server" {
  name_prefix       = "elk"
  port              = 9200
  protocol          = "HTTP"
  protocol_version  = "HTTP1"
  target_type       = "instance"
  vpc_id            = aws_vpc.project4.id

  health_check {
    enabled         = true
    healthy_threshold = 2
    unhealthy_threshold = 2
    interval = 30
    matcher = 200
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 5
  }
}
resource "aws_lb_target_group" "elastic_dev" {
  name_prefix       = "dev"
  port              = 8080
  protocol          = "HTTP"
  protocol_version  = "HTTP1"
  target_type       = "instance"
  vpc_id            = aws_vpc.project4.id

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