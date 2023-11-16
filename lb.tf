# note that this creates the alb, target group, and access logs
# the listeners are defined in lb-http.tf and lb-https.tf
# delete either of these if your app doesn't need them
# but you need at least one

# Whether the application is available on the public internet,
# also will determine which subnets will be used (public or private)
variable "internal" {
  default = false
}

# The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused
variable "deregistration_delay" {
  default = "30"
}


# How often to check the liveliness of the container
variable "health_check_interval" {
  default = "30"
}

# How long to wait for the response on the health check path
variable "health_check_timeout" {
  default = "10"
}

# What HTTP response code to listen for
variable "health_check_matcher" {
  default = "200"
}

variable "lb_access_logs_expiration_days" {
  default = "3"
}

resource "aws_alb" "main" {
  name = "${var.app}-${local.account_id}"

  # launch lbs in public or private subnets based on "internal" variable
  internal = var.internal
  subnets = var.codebuild_subnet_ids
  security_groups = [aws_security_group.nsg_lb.id]

  # enable access logs in order to get support from aws
  access_logs {
    enabled = true
    bucket  = aws_s3_bucket.lb_access_logs.bucket
  }
}

resource "aws_alb_target_group" "main" {
  name                 = "${var.app}-${local.account_id}"
  port                 = var.container_port #var.lb_port
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = var.deregistration_delay

  health_check {
    path                = var.health_check
    matcher             = var.health_check_matcher
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

}

data "aws_elb_service_account" "main" {
}

# bucket for storing ALB access logs
resource "aws_s3_bucket" "lb_access_logs" {
  bucket        = "${var.app}-${local.account_id}-lb-access-logs"
  force_destroy = true

  lifecycle_rule {
    id                                     = "cleanup"
    enabled                                = true
    abort_incomplete_multipart_upload_days = 1
    prefix                                 = ""

    expiration {
      days = var.lb_access_logs_expiration_days
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

# give load balancing service access to the bucket
resource "aws_s3_bucket_policy" "lb_access_logs" {
  bucket = aws_s3_bucket.lb_access_logs.id

  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.lb_access_logs.arn}",
        "${aws_s3_bucket.lb_access_logs.arn}/*"
      ],
      "Principal": {
        "AWS": [ "${data.aws_elb_service_account.main.arn}" ]
      }
    }
  ]
}
POLICY
}

# The load balancer DNS name
output "lb_dns" {
  value = aws_alb.main.dns_name
}
