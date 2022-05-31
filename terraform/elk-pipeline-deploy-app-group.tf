resource "aws_codedeploy_app" "elk_server" {
  compute_platform = "Server"
  name             = "terraform-elk-server"
}

resource "aws_codedeploy_deployment_group" "elk_server" {
  deployment_group_name  = "elk-main-deploy"
  service_role_arn       = aws_iam_role.codedeploy_role.arn
  app_name               = aws_codedeploy_app.elk_server.name
  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  autoscaling_groups = [ aws_autoscaling_group.elk.name ]

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

}