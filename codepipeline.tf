data "aws_secretsmanager_secret" "github_credentials"{
    arn = aws_secretsmanager_secret_version.github_credentials.arn
}

data "aws_secretsmanager_secret_version" "github_credentials" {
  secret_id = data.aws_secretsmanager_secret.github_credentials.id
}

resource "aws_codepipeline" "codepipeline" {

    name = var.codepipeline_name
    role_arn = aws_iam_role.codepipeline-role.arn

     artifact_store {
         type="S3"
         location = aws_s3_bucket.terraform_state.bucket
     }
    stage {
        name = "Source"
        action{
            name = "Source"
            category = "Source"
            owner = "ThirdParty"
            provider = "GitHub"
            output_artifacts = ["infra_vpc_code"]
            version = 1
            configuration = {
              OAuthToken           = data.aws_secretsmanager_secret_version.github_credentials.secret_string 
              Owner                = "knohr"
              Repo                 = "supersetdemo"
              Branch               = "master"
              PollForSourceChanges = true 
            }
        }
    }

    stage {
        name ="Plan"
        action{
            name = "Build"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["infra_vpc_code"]
            configuration = {
                ProjectName = aws_codebuild_project.codebuild_project_plan_stage.name
            }
        }
    }

    stage {
        name ="Deploy"
        action{
            name = "Deploy"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["infra_vpc_code"]
            configuration = {
                ProjectName = aws_codebuild_project.codebuild_project_apply_stage.name
            }
        }
    }
    stage {
        name ="Docker"
        action{
            name = "Docker"
            category = "Build"
            provider = "CodeBuild"
            version = "1"
            owner = "AWS"
            input_artifacts = ["infra_vpc_code"]
            configuration = {
                ProjectName = aws_codebuild_project.codebuild_project_docker_stage.name
            }
        }
    }
}
