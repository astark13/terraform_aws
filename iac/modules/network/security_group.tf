# resource "aws_security_group" "sg" {
#   count       = var.sg == null ? 0 : 1
#   name        = var.sg.name
#   description = var.sg.description
#   vpc_id      = var.sg.vpc_id
# }

##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_vpc" "sg" {
  count = var.sg == null ? 0 : 1
  tags  = {
      Name = "${var.sg.vpc}"
  }
}

resource "aws_security_group" "sg" {
  count       = var.sg == null ? 0 : 1
  name        = var.sg.name
  description = var.sg.description
  vpc_id      = data.aws_vpc.sg[0].id
  tags        = var.sg.tags
}
