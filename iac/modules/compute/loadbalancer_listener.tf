# resource "aws_lb_listener" "lb_listener" {
#   count             = var.lb_listener == null ? 0 : 1
#   load_balancer_arn = var.lb_listener.load_balancer_arn
#   port              = var.lb_listener.port
#   protocol          = var.lb_listener.protocol
  
#   # valid default_action options:
#   # authenticate-cognito/authenticate-oidc/fixed-response/forward/redirect
#   default_action {
#     type             = var.lb_listener.action_type
#     target_group_arn = var.lb_listener.target_group_arn
#   }

#   tags = var.lb_listener.tags
# }

##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_lb" "lb_listener" {
  count = var.lb_listener == null ? 0 : 1
  name  = var.lb_listener.load_balancer_name
}

data "aws_lb_target_group" "lb_listener" {
  count = var.lb_listener == null ? 0 : 1
  name  = var.lb_listener.target_group_name
}

resource "aws_lb_listener" "lb_listener" {
  count             = var.lb_listener == null ? 0 : 1
  load_balancer_arn = data.aws_lb.lb_listener[0].arn
  port              = var.lb_listener.port
  protocol          = var.lb_listener.protocol
  
  # valid default_action options:
  # authenticate-cognito/authenticate-oidc/fixed-response/forward/redirect
  default_action {
    type             = var.lb_listener.action_type
    target_group_arn = data.aws_lb_target_group.lb_listener[0].arn
  }

  tags = var.lb_listener.tags
}