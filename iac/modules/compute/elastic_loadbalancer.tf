# https://docs.aws.amazon.com/prescriptive-guidance/latest/load-balancer-stickiness/subnets-routing.html
# https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-application-load-balancer.html

# resource "aws_lb" "loadbalancer" {
#   count = var.lb == null ? 0 : 1   
#   name               = var.lb.name
#   internal           = var.lb.internal
#   # valid lb types: application / gateway / network
#   load_balancer_type = var.lb.load_balancer_type
#   security_groups    = var.lb.security_groups
#   # public subnets which the lb spans
#   subnets            = var.lb.subnets

# #   access_logs {
# #     bucket  = var.lb.s3_bucket
# #     prefix  = var.lb.s3_prefix
# #     enabled = var.lb.s3_access_logs_enabled
# #   }

#   tags          = var.lb.tags
# }

##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_security_group" "lb" {
  for_each = toset(var.lb != null ? var.lb.security_group_names : [])
  tags  = {
    Name = each.key
  }
}

# vpc_zone_identifier
data "aws_subnet" "lb" {
  for_each = toset(var.lb != null ? var.lb.subnet_names : [])
  tags = {
    Name = each.key
  }
}

locals {
  subnet_id         = var.lb != null ? [for subnet in data.aws_subnet.lb : subnet.id] : []
  security_group_id = var.lb != null ? [for security_group in data.aws_security_group.lb : security_group.id] : []
}

resource "aws_lb" "loadbalancer" {
  count              = var.lb == null ? 0 : 1   
  name               = var.lb.name
  internal           = var.lb.internal
  # valid lb types: application / gateway / network
  load_balancer_type = var.lb.load_balancer_type
  security_groups    = local.security_group_id
  # public subnets which the lb spans
  subnets            = local.subnet_id

#   access_logs {
#     bucket  = var.lb.s3_bucket
#     prefix  = var.lb.s3_prefix
#     enabled = var.lb.s3_access_logs_enabled
#   }

  tags          = var.lb.tags
}