# resource "aws_lb_target_group" "lb_tg" {
#   count       = var.lb_tg == null ? 0 : 1
#   name        = var.lb_tg.name
#   #target_type = var.lb_tg.target_type
#   port        = var.lb_tg.port
#   protocol    = var.lb_tg.protocol
#   vpc_id      = var.lb_tg.vpc_id
#   tags        = var.lb_tg.tags
# }

##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_vpc" "lbtg" {
  count = var.lb_tg == null ? 0 : 1
  tags  = {
      Name = "${var.lb_tg.vpc}"
  }
}

resource "aws_lb_target_group" "lb_tg" {
  count       = var.lb_tg == null ? 0 : 1
  name        = var.lb_tg.name
  #target_type = var.lb_tg.target_type
  port        = var.lb_tg.port
  protocol    = var.lb_tg.protocol
  vpc_id      = data.aws_vpc.lbtg[0].id
  tags        = var.lb_tg.tags
}