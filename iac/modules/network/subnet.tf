# -> Don't forget to insert the new vpc_id!!!
# -> It's typically good practice to create at least one subnet
# for each availability zone (AZ) in your region
# -> An ELB needs at least 2 subnets in two different AZs

data "aws_vpc" "subnet" {
  count = var.subnet == null ? 0 : 1
  id    = var.subnet.vpc_id
}

resource "aws_subnet" "subnet" {
  count                   = var.subnet == null ? 0 : 1
  vpc_id                  = var.subnet.vpc_id
  availability_zone       = var.subnet.availability_zone
  cidr_block              = cidrsubnet(data.aws_vpc.subnet[0].cidr_block, var.subnet.newbits, var.subnet.netnum)
  map_public_ip_on_launch = var.subnet.map_public_ip_on_launch
  tags                    = var.subnet.tags
}
