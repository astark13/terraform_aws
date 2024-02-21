resource "aws_default_security_group" "default" {
  count  = var.dsg == null ? 0 : 1
  vpc_id = var.dsg.vpc_id
}