
# It's important to note that a VPC can have multiple route tables,
# but only one main route table. While additional route tables
# can be associated with specific subnets,
# the main route table remains the default route table for all non-specified subnets.

resource "aws_main_route_table_association" "mrt" {
  count          = var.mrt == null ? 0 : 1
  vpc_id         = var.mrt.vpc_id
  route_table_id = var.mrt.route_table_id
}