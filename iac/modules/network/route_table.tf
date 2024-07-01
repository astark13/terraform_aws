##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_vpc" "rt" {
  count = var.rt == null ? 0 : 1
  tags  = {
    Name = "${var.rt.vpc}"
  }
}

resource "aws_route_table" "rt" {
  count  = var.rt == null ? 0 : 1
  vpc_id = data.aws_vpc.rt[0].id
  tags   = var.rt.tags
}