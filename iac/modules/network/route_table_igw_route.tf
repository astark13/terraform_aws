##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_route_table" "rt_igw_r" {
  count = var.rt_igw_r == null ? 0 : 1
  tags  = {
    Name = "${var.rt_igw_r.rt}"
  }
}

data "aws_internet_gateway" "igw" {
  count = var.rt_igw_r == null ? 0 : 1
  tags  = {
    Name = "${var.rt_igw_r.destination_name}"
  }
}

resource "aws_route" "rt_igw_r" {
  count                  = var.rt_igw_r == null ? 0 : 1
  route_table_id         = data.aws_route_table.rt_igw_r[0].id
  destination_cidr_block = var.rt_igw_r.destination_cidr_block
  gateway_id             = data.aws_internet_gateway.igw[0].id
}