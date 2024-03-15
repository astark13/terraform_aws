resource "aws_route_table" "rt" {
  count  = var.rt == null ? 0 : 1
  vpc_id = var.rt.vpc_id

#https://www.cloudbolt.io/terraform-best-practices/terraform-dynamic-blocks/
# used to configure multiple duplicate elements within a resource
  dynamic "route" {
    for_each = var.rt.route
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.gateway_id
    }
  }
  tags = var.rt.tags
}