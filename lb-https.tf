resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_alb.main.id
  port              = var.lb_port
  protocol          = var.lb_protocol
  certificate_arn    = "arn:aws:acm:us-west-2:535710392721:certificate/9c661d84-1bd7-430d-8eff-d7e129640385"

  default_action {
    target_group_arn = aws_alb_target_group.main.id
    type             = "forward"
  }
}

resource "aws_security_group_rule" "ingress_lb_https" {
  type              = "ingress"
  description       = var.lb_protocol
  from_port         = var.lb_port
  to_port           = var.container_port
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nsg_lb.id
}
