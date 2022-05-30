resource "aws_codedeploy_app" "reserv_api_server" {
  compute_platform = "Server"
  name             = "terraform-reservation-api-server"
}

resource "aws_codedeploy_deployment_group" "reserv_api_server" {
  deployment_group_name  = "develop-deploy-group"
  service_role_arn       = aws_iam_role.codedeploy_role.arn
  app_name               = aws_codedeploy_app.reserv_api_server.name
  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  autoscaling_groups = [ aws_autoscaling_group.reserv_api_server.name ]

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

}