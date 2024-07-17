# resource "aws_security_group_rule" "sgr" {
#   count             = var.sgr == null ? 0 : 1
#   description       = var.sgr.description
#   type              = var.sgr.type
#   from_port         = var.sgr.from_port
#   to_port           = var.sgr.from_port
#   protocol          = var.sgr.protocol
#   cidr_blocks       = var.sgr.cidr_block
#   security_group_id = var.sgr.security_group_id
# }

##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_security_group" "sgr" {
  count = var.sgr == null ? 0 : 1
  tags  = {
      Name = "${var.sgr.security_group}"
  }
}

resource "aws_security_group_rule" "sgr" {
  count             = var.sgr == null ? 0 : 1
  description       = var.sgr.description
  type              = var.sgr.type
  from_port         = var.sgr.from_port
  to_port           = var.sgr.from_port
  protocol          = var.sgr.protocol
  cidr_blocks       = var.sgr.cidr_block
  security_group_id = data.aws_security_group.sgr[0].id
}