data "aws_vpc" "ig" {
  count = var.ig == null ? 0 : 1
  id    = var.ig.vpc_id
}

resource "aws_internet_gateway" "ig" {
  count  = var.ig == null ? 0 : 1
  vpc_id = data.aws_vpc.ig[0].id
  tags   = var.tags
}