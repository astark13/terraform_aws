resource "aws_security_group_rule" "sgr" {
  count             = var.sgr == null ? 0 : 1
  description       = var.sgr.description
  type              = var.sgr.type
  from_port         = var.sgr.from_port
  to_port           = var.sgr.from_port
  protocol          = var.sgr.protocol
  cidr_blocks       = var.sgr.cidr_block
  security_group_id = var.sgr.security_group_id
}