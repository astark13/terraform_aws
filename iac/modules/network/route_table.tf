data "aws_vpc" "rt" {
  count = var.rt == null ? 0 : 1
  id    = var.rt.vpc_id
}

data "aws_internet_gateway" "rt" {
  count = var.rt == null ? 0 : 1
  filter {
    name   = "attachment.vpc-id"
    values = [var.rt.vpc_id]
  }
}

# resource "aws_route_table" "rt" {
#   count  = var.rt == null ? 0 : 1
#   vpc_id = var.rt.vpc_id

#   # since this is exactly the route AWS will create,
#   # the route will be adopted
#   route {
#     cidr_block = "10.0.0.0/26"
#     gateway_id = "local"
#   }

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = data.aws_internet_gateway.rt[0].id
#   }
#   tags = var.rt.tags
# }

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