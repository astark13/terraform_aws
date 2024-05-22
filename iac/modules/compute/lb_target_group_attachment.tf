resource "aws_lb_target_group_attachment" "lb_tg_attach" {
  count            = var.lb_tga == null ? 0 : 1
  target_group_arn = var.lb_tga.target_group_arn
  target_id        = var.lb_tga.target_id
  port             = var.lb_tga.port
}