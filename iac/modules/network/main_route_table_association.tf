
resource "aws_main_route_table_association" "mrt" {
  count          = var.mrt == null ? 0 : 1
  vpc_id         = var.mrt.vpc_id
  route_table_id = var.mrt.route_table_id
}