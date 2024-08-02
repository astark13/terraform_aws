##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_security_group" "sger" {
  count = var.sger == null ? 0 : 1
  tags  = {
      Name = "${var.sger.security_group}"
  }
}

resource "aws_vpc_security_group_egress_rule" "sger" {
  count             = var.sger == null ? 0 : 1
  description       = var.sger.description
  security_group_id = data.aws_security_group.sger[0].id
  cidr_ipv4         = var.sger.cidr_ipv4
  from_port         = var.sger.from_port
  ip_protocol       = var.sger.ip_protocol
  to_port           = var.sger.to_port
}