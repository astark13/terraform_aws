data "aws_vpc" "drt" {
  count = var.drt == null ? 0 : 1
  id    = var.drt.vpc_id
}

data "aws_internet_gateway" "default" {
  count = var.drt == null ? 0 : 1
  filter {
    name   = "attachment.vpc-id"
    values = [var.drt.vpc_id]
  }
}

resource "aws_default_route_table" "drt" {
  count                  = var.drt == null ? 0 : 1
  default_route_table_id = data.aws_vpc.drt[0].main_route_table_id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "10.0.0.0/26"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = data.aws_internet_gateway.default[0].id
  }
  #tags = var.tags
}
