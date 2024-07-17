# resource "aws_route_table_association" "rta" {
#   count          = var.rta == null ? 0 : 1
#   subnet_id      = var.rta.subnet_id
#   route_table_id = var.rta.route_table_id
# }

##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_subnet" "rta" {
  count = var.rta == null ? 0 : 1
  tags = {
    Name ="${var.rta.subnet}"
  }
}

data "aws_route_table" "rta" {
  count = var.rta == null ? 0 : 1
  tags  = {
    Name = "${var.rta.route_table}"
  }
}

resource "aws_route_table_association" "rta" {
  count          = var.rta == null ? 0 : 1
  subnet_id      = data.aws_subnet.rta[0].id
  route_table_id = data.aws_route_table.rta[0].id
}
