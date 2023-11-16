variable "backend-ddb-table" {
    description = "Terraform backend locking table."
    type        = string
    default     = "tf_backend"
}

variable "aws_region" {
    description = ""
    type        = string
    default     = "us-west-2"
}

variable "lb_port"{
    default     = "443"
}

variable "lb_protocol" {
  default = "HTTPS"
}

variable "backend-s3-bucket" { 
    description = ""
    type        = string
    default     = "value"
}

variable "codebuild_subnet_arns" {
    description = ""
    type        = list
    default     = [
        "arn:aws:ec2:us-west-2:535710392721:subnet/subnet-06e5a1b3d5c3d3b8d",
        "arn:aws:ec2:us-west-2:535710392721:subnet/subnet-0e2faf05ef7fc2906"]
}

variable "codebuild_subnet_ids" {
    description = ""
    type        = list
    default     = [
        "subnet-06e5a1b3d5c3d3b8d",
        "subnet-0e2faf05ef7fc2906"]
}

variable "vpc_id" {
    description = ""
    type        = string
    default     = "vpc-00252c1f420962768"
}

variable "account_id" {
    description = ""
    type        = string
    default     = ""
}

variable "codebuild_role_name" {
    type = string
    default = "infra-vpc-codebuild-role" 
}

variable "codepipeline_role_name" {
    type = string
    default = "infra-vpc-codepipeline-role"
}

variable "codebuild_policy_name" {
    type = string
    default = "infra-vpc-codebuild-policy" 
}

variable "codepipeline_policy_name" {
    type = string
    default = "infra-vpc-codepipeline-policy"
}

variable "codebuild_plan_project_name" {
    type = string
    default = "infra-vpc-codebuild-project-plan" 
}

variable "codebuild_apply_project_name" {
    type = string
    default = "infra-vpc-codebuild-project-apply" 
}

variable "codebuild_docker_project_name" {
    type = string
    default = "infra-vpc-codebuild-project-docker" 
}

variable "codepipeline_name" {
    type = string
    default = "infra-superset" 
}
