##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_route_table" "rt_ngw_r" {
  count = var.rt_ngw_r == null ? 0 : 1
  tags  = {
    Name = "${var.rt_ngw_r.rt}"
  }
}

data "aws_nat_gateway" "ngw" {
  count = var.rt_ngw_r == null ? 0 : 1
  tags  = {
    Name = "${var.rt_ngw_r.destination_name}"
  }
}

resource "aws_route" "rt_ngw_r" {
  count                  = var.rt_ngw_r == null ? 0 : 1
  route_table_id         = data.aws_route_table.rt_ngw_r[0].id
  destination_cidr_block = var.rt_ngw_r.destination_cidr_block
  nat_gateway_id         = data.aws_nat_gateway.ngw[0].id
}