resource "aws_route_table_association" "rta" {
  count          = var.rta == null ? 0 : 1
  subnet_id      = var.rta.subnet_id
  route_table_id = var.rta.route_table_id
}