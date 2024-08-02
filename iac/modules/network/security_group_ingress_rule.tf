##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_security_group" "sgir" {
  count = var.sgir == null ? 0 : 1
  tags  = {
      Name = "${var.sgir.security_group}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sgir" {
  count             = var.sgir == null ? 0 : 1
  description       = var.sgir.description
  security_group_id = data.aws_security_group.sgir[0].id
  cidr_ipv4         = var.sgir.cidr_ipv4
  from_port         = var.sgir.from_port
  ip_protocol       = var.sgir.ip_protocol
  to_port           = var.sgir.to_port
}