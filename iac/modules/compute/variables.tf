variable "ec2" {
  type = object({
    ami           = string
    instance_type = string
    subnet_id     = string
  })
  default = null
}

variable "launch_template" {
  type = object({
    name                   = string
    image_id               = string
    instance_type          = string
    vpc_security_group     = set(string)
    #vpc_security_group_ids = set(string)
    user_data              = string
    iam_instance_profile   = string
    tag_specifications     = list(
      object({
      # available resource types values:
      # instance | volume | network-interface | spot-instances-request
      resource_type = string
      # a map of tags to assign to the launch template
      tags          = map(string)
      })
    )
  })
  default = null
} 

# ec2_with_launch_template
variable "ec2lt" {
  type = object({
    subnet_id          = string
    launch_template_id = string
    tags               = map(string)
  })
  default = null
}

# loadbalancer target group
variable "lb_tg" {
  type = object({
    name        = string
    #target_type = string
    port        = number
    protocol    = string
    vpc_id      = string
    tags        = map(string)
  })
  default = null
}

# autoscaling_group
variable "asg" {
  type = object({
    name                = string
    vpc_zone_identifier = list(string)
    desired_capacity    = number
    max_size            = number
    min_size            = number
    target_group_arns   = set(string)
    launch_template_id  = string
    tag = list(
      object({
        key                 = string
        value               = string
        propagate_at_launch = bool 
      })
    )  
  })
  default = null
}

# autoscaling_policy
variable "asgplc" {
  type = object({
    name                   = string
    policy_type            = string
    scaling_adjustment     = number
    adjustment_type        = string
    cooldown               = number
    autoscaling_group_name = string
    predefined_metric_type = string
    target_value           = number
  })
  default = null
}

# loadbalancer
variable "lb" {
  type = object({
    name               = string
    internal           = bool
    load_balancer_type = string
    security_groups    = list(string)
    subnets            = list(string)
    # access_logs = object({
    #   s3_bucket              = string
    #   s3_prefix              = string
    #   s3_access_logs_enabled = bool
    # })
    tags               = map(string)
  })
  default = null
}

# loadbalancer listener
variable "lb_listener" {
  type = object({
    load_balancer_arn = string
    port              = number
    protocol          = string
    action_type       = string
    target_group_arn  = string
    tags              = map(string)
  })
  default = null
}

# loadbalancer target group attachment
variable "lb_tga" {
  type = object({
    target_group_arn = string
    target_id        = string
    port             = number
  })
  default = null
}

variable "tags" {
  default = null
}