resource "aws_codestarconnections_connection" "github" {
  name          = "terraform-project4"
  provider_type = "GitHub"
}

resource "aws_codepipeline" "codepipeline" {
  name     = "reservation-api-server"
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
        ConnectionArn    = aws_codestarconnections_connection.github.arn
        FullRepositoryId = "${var.github_organization}/${var.github_repository}"
        BranchName       = "develop"
        OutputArtifactFormat = "CODE_ZIP"
      }
    }
  }

  stage {
    name = "Build"

    action {
      run_order = 1
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.front.name
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
      provider        = "S3"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        BucketName = "project4-frontend-react"
        Extract = "true"
      }
    }

    action {
      run_order       = 2
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      region          = data.aws_availability_zone.az.region
      input_artifacts = ["SourceArtifact"]
      version         = "1"

      configuration = {
        ApplicationName = aws_codedeploy_app.reserv_api_server.name
        DeploymentGroupName = aws_codedeploy_deployment_group.reserv_api_server.deployment_group_name
      }
    }
  }
}
