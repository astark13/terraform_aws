resource "aws_security_group" "sg" {
  count       = var.sg == null ? 0 : 1
  name        = var.sg.name
  description = var.sg.description
  vpc_id      = var.sg.vpc_id
}