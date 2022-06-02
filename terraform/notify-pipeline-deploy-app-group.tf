resource "aws_codedeploy_app" "notify_server" {
  compute_platform = "Server"
  name             = "terraform-notify-server"
}

resource "aws_codedeploy_deployment_group" "notify_server" {
  deployment_group_name  = "notify-main-deploy"
  service_role_arn       = aws_iam_role.codedeploy_role.arn
  app_name               = aws_codedeploy_app.notify_server.name
  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  autoscaling_groups = [ aws_autoscaling_group.notify.name ]

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

}