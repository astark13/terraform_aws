resource "aws_nat_gateway" "ngw" {
  count         = var.ngw == null ? 0 : 1
  allocation_id = var.ngw.allocation_id
  subnet_id     = var.ngw.subnet_id
  tags          = var.ngw.tags
}