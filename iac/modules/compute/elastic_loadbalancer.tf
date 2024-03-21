# https://docs.aws.amazon.com/prescriptive-guidance/latest/load-balancer-stickiness/subnets-routing.html
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-application-load-balancer.html

resource "aws_lb" "loadbalancer" {
  count = var.lb ==null ? 0 : 1   
  name               = var.lb.name
  internal           = var.lb.internal
  # valid lb types: application / gateway / network
  load_balancer_type = var.lb.load_balancer_type
  security_groups    = var.lb.security_groups
  # public subnets which the lb spans
  subnets            = var.lb.subnets

#   access_logs {
#     bucket  = var.lb.s3_bucket
#     prefix  = var.lb.s3_prefix
#     enabled = var.lb.s3_access_logs_enabled
#   }

  tags          = var.lb.tags
}