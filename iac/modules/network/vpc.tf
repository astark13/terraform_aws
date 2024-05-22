# UNCOMMENT in case global variables are needed !!!
# resource "aws_vpc" "vpc" {
#   count      = var.vpc == null ? 0 : 1
#   cidr_block = var.vpc.cidr_block
#   tags       = {
#     Name = "${var.project}-${var.environment}-vpc"
#   }
# }

# variable "dummy" {
#   type = string
#   description = "used to create resources sequentially"
# }

resource "aws_vpc" "vpc" {
  count      = var.vpc == null ? 0 : 1
  cidr_block = var.vpc.cidr_block
  tags       = var.vpc.tags
}


