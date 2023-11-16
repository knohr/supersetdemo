resource "aws_ecr_repository" "superset" {
  name                 = "superset"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
