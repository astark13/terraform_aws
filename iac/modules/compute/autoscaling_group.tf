resource "aws_autoscaling_group" "asg" {
  count               = var.asg == null ? 0 : 1
  name                = var.asg.name
  # id's of subnets in which EC2 instances will reside 
  vpc_zone_identifier = var.asg.vpc_zone_identifier
  desired_capacity    = var.asg.desired_capacity
  max_size            = var.asg.max_size
  min_size            = var.asg.min_size
  target_group_arns   = var.asg.target_group_arns

  launch_template {
    id      = var.asg.launch_template_id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = var.asg.tag
    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = tag.value.propagate_at_launch
    }
  }
}