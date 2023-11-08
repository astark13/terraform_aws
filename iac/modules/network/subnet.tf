data "aws_vpc" "subnet" {
  count = var.subnet == null ? 0 : 1
  id    = var.subnet.vpc_id
}

resource "aws_subnet" "subnet" {
  count             = var.subnet == null ? 0 : 1
  vpc_id            = data.aws_vpc.subnet[0].id
  availability_zone = var.subnet.availability_zone
  cidr_block        = cidrsubnet(data.aws_vpc.subnet[0].cidr_block, var.subnet.newbits, var.subnet.netnum)
  tags              = var.tags
}
