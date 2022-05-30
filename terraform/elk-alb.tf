resource "aws_alb" "elk_server" {
  name            = "elk-server"
  internal        = false
  load_balancer_type = "application"
  idle_timeout    = 60
  security_groups = [aws_security_group.public.id]
  subnets         = [aws_subnet.public1.id, aws_subnet.public2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "project4-elk"
  }
}
