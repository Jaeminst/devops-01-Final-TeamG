resource "aws_codestarconnections_connection" "elk_github" {
  name          = "terraform-project4-elk"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "elk_codepipeline" {
  name     = "elk-server"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

    encryption_key {
      id   = data.aws_kms_alias.s3.arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      run_order        = 1
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.elk_github.arn
        FullRepositoryId = "${var.github_organization}/${var.github_repository_elk}"
        BranchName       = "main"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      run_order       = 1
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      region          = data.aws_availability_zone.az.region
      input_artifacts = ["SourceArtifact"]
      version         = "1"

      configuration = {
        ApplicationName = aws_codedeploy_app.elk_server.name
        DeploymentGroupName = aws_codedeploy_deployment_group.elk_server.deployment_group_name
      }
    }
  }
}
