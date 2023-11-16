resource "aws_security_group" "nsg_lb" {
  name        = "${var.app}-${local.account_id}-lb"
  description = "Allow connections from external resources while limiting connections from ${var.app}-${local.account_id}-lb to internal resources"
  vpc_id      = var.vpc_id

}

resource "aws_security_group" "nsg_task" {
  name        = "${var.app}-${local.account_id}-task"
  description = "Limit connections from internal resources while allowing ${var.app}-${local.account_id}-task to connect to all external resources"
  vpc_id      = var.vpc_id

}

# Rules for the LB (Targets the task SG)

resource "aws_security_group_rule" "nsg_lb_egress_rule" {
  description              = "Only allow SG ${var.app}-${local.account_id}-lb to connect to ${var.app}-${local.account_id}-task on port ${var.container_port}"
  type                     = "egress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nsg_task.id

  security_group_id = aws_security_group.nsg_lb.id
}

# Rules for the TASK (Targets the LB SG)
resource "aws_security_group_rule" "nsg_task_ingress_rule" {
  description              = "Only allow connections from SG ${var.app}-${local.account_id}-lb on port ${var.container_port}"
  type                     = "ingress"
  from_port                = var.container_port
  to_port                  = var.container_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.nsg_lb.id

  security_group_id = aws_security_group.nsg_task.id
}

resource "aws_security_group_rule" "nsg_task_egress_rule" {
  description = "Allows task to establish connections to all resources"
  type        = "egress"
  from_port   = "0"
  to_port     = "0"
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.nsg_task.id
}
