resource "aws_vpc" "vpc" {
  count      = var.vpc == null ? 0 : 1
  cidr_block = var.vpc.cidr_block
  tags       = var.tags
}
