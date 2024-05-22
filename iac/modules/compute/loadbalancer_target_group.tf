resource "aws_lb_target_group" "lb_tg" {
  count       = var.lb_tg == null ? 0 : 1
  name        = var.lb_tg.name
  #target_type = var.lb_tg.target_type
  port        = var.lb_tg.port
  protocol    = var.lb_tg.protocol
  vpc_id      = var.lb_tg.vpc_id
  tags        = var.lb_tg.tags
}