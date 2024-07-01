# # resource "aws_route_table" "rtd" {
# #   count  = var.rtd == null ? 0 : 1
# #   vpc_id = var.rtd.vpc_id

# # #https://www.cloudbolt.io/terraform-best-practices/terraform-dynamic-blocks/
# # # used to configure multiple duplicate elements within a resource
# #   dynamic "route" {
# #     for_each = var.rtd.route
# #     content {
# #       cidr_block = route.value.cidr_block
# #       gateway_id = route.value.gateway_id
# #     }
# #   }
# #   tags = var.rtd.tags
# # }

# ##################################
# # the code below is configured to create these resources as part
# # of the desired architecture in a SINGLE "terraform apply"
# ##################################

# data "aws_vpc" "rtd" {
#   count = var.rtd == null ? 0 : 1
#   tags  = {
#     Name = "${var.rtd.vpc}"
#   }
# }

# data "aws_nat_gateway" "ngw" {
#   count = var.rtd == null ? 0 : 1
#   tags  = {
#     Name = "${var.rtd.route[1].gateway_id}"
#   }
# }

# data "aws_internet_gateway" "ig" {
#   count  = var.rtd == null ? 0 : 1
#   tags  = {
#     Name = "${var.rtd.route[1].gateway_id}"
#   }
# }

# resource "aws_route_table" "rtd" {
#   count  = var.rtd == null ? 0 : 1
#   vpc_id = data.aws_vpc.rtd

# #https://www.cloudbolt.io/terraform-best-practices/terraform-dynamic-blocks/
# # used to configure multiple duplicate elements within a resource
#   dynamic "route" {
#     for_each = var.rtd.route
#     content {
#       cidr_block = route.value.cidr_block
#       gateway_id = route.value.gateway_id
#     }
#   }
#   tags = var.rtd.tags
# }