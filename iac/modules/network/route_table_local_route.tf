##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_route_table" "rt" {
  count = var.rt_l_r == null ? 0 : 1
  tags  = {
    Name = "${var.rt_l_r.rt}"
  }
}

resource "aws_route" "rt_l_r" {
  count                  = var.rt_l_r == null ? 0 : 1
  route_table_id         = data.aws_route_table.rt[0].id
  destination_cidr_block = var.rt_l_r.destination_cidr_block
  gateway_id             = "local"
}