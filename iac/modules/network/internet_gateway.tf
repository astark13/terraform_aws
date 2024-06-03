# resource "aws_internet_gateway" "ig" {
#   count  = var.ig == null ? 0 : 1
#   vpc_id = var.ig.vpc_id
#   tags   = var.ig.tags
# }

# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
data "aws_vpc" "ig" {
  count = var.ig == null ? 0 : 1
  tags  = {
    Name = "${var.ig.vpc}"
  }
}

resource "aws_internet_gateway" "ig" {
  count  = var.ig == null ? 0 : 1
  vpc_id = data.aws_vpc.ig[0].id
  tags   = var.ig.tags
}