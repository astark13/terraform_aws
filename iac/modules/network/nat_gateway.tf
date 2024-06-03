# resource "aws_nat_gateway" "ngw" {
#   count         = var.ngw == null ? 0 : 1
#   allocation_id = var.ngw.allocation_id
#   subnet_id     = var.ngw.subnet_id
#   tags          = var.ngw.tags
# }

# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
data "aws_eip" "ngw" {
  count = var.ngw == null ? 0 : 1
  tags = {
    Name ="${var.ngw.eip}"
  }
}

data "aws_subnet" "ngw" {
  count = var.ngw == null ? 0 : 1
  tags = {
    Name ="${var.ngw.subnet}"
  }
}

resource "aws_nat_gateway" "ngw" {
  count         = var.ngw == null ? 0 : 1
  allocation_id = data.aws_eip.ngw[0].id
  subnet_id     = data.aws_subnet.ngw[0].id
  tags          = var.ngw.tags
}