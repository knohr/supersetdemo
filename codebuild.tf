resource "aws_codebuild_project" "codebuild_project_plan_stage" {
  name          = var.codebuild_plan_project_name
  description   = "Terraform Planning Stage for infra VPC"
  service_role  = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:latest"
    type                        = "LINUX_CONTAINER"
 }
 
  source {
     type   = "CODEPIPELINE"
     buildspec = file("buildspec/plan-buildspec.yml")
 }
}

resource "aws_codebuild_project" "codebuild_project_apply_stage" {
  name          = var.codebuild_apply_project_name
  description   = "Terraform Apply Stage for infra VPC"
  service_role  = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "hashicorp/terraform:latest"
    type                        = "LINUX_CONTAINER"
 }

  source {
     type   = "CODEPIPELINE"
     buildspec = file("buildspec/apply-buildspec.yml")
 }
}

resource "aws_codebuild_project" "codebuild_project_docker_stage" {
  name          = var.codebuild_docker_project_name
  description   = "Terraform Apply Stage for infra VPC"
  service_role  = aws_iam_role.codebuild-role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:7.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode = true
 }

  source {
     type   = "CODEPIPELINE"
     buildspec = file("buildspec/buildspec-superset.yml")
 }
}
