variable "aws_region" {
  type = string
}

# # UNCOMMENT in case you want to
# # use global variables
# # variable "project" {
# #   type = string
# # }

# # UNCOMMENT in case you want to
# # use global variables
# # variable "environment" {
# #   type = string
# # }

variable "vpc" {
  type = list(
    object({
      cidr_block = string
      # COMMENT in case global variables are used
      tags = map(string)
    })
  )
}

# variable "subnet" {
#   type = list(
#     object({
#       # if using data source for vpc_id, 
#       # provide vpc tag "Name", else provide vpc_id directly
#       vpc_id                  = string
#       availability_zone       = string
#       newbits                 = number
#       netnum                  = number
#       map_public_ip_on_launch = bool
#       tags                    = map(string)
#     })
#   )
# }

variable "subnet" {
  type = list(
    object({
      # if using data source for vpc_id, 
      # provide vpc tag "Name", else provide vpc_id directly
      vpc                     = string
      availability_zone       = string
      newbits                 = number
      netnum                  = number
      map_public_ip_on_launch = bool
      tags                    = map(string)
    })
  )
}

# # internet_gateway
# variable "ig" {
#   type = list(
#     object({
#       # if using data source for vpc_id, 
#       # provide vpc tag "Name", else provide vpc_id directly
#       vpc_id = string
#       tags   = map(string)
#     })
#   )
# }

# internet_gateway
variable "ig" {
  type = list(
    object({
      # if using data source for vpc_id, 
      # provide vpc tag "Name", else provide vpc_id directly
      vpc  = string
      tags = map(string)
    })
  )
}

# elastic_ip
variable "eip" {
  type = list(
    object({
      domain = string
      tags   = map(string)
    })
  )
}

# # nat_gateway
# variable "ngw" {
#   type = list(
#     object({
#       allocation_id = string
#       subnet_id     = string
#       tags          = map(string)
#     })
#   )
# }

# nat_gateway
variable "ngw" {
  type = list(
    object({
      eip    = string
      subnet = string
      tags   = map(string)
    })
  )
}

# route_table
variable "rt" {
  type = list(
    object({
      # if using data source for vpc_id, 
      # provide vpc tag "Name", else provide vpc_id directly
      vpc  = string
      tags = map(string)
    })
  )
}

# route_table_local_route
variable "rt_l_r" {
  type = list(
    object({
      # if using data source for route_table_id, 
      # provide route_table tag "Name", else provide route_table_id
      rt                     = string
      destination_cidr_block = string
    })
  )
}

# route_table_ngw_route
variable "rt_ngw_r" {
  type = list(
    object({
      # if using data source for route_table_id, 
      # provide route_table tag "Name", else provide route_table_id
      rt                     = string
      destination_cidr_block = string
      #destination_type       = string
      destination_name = string
    })
  )
}

# route_table_igw_route
variable "rt_igw_r" {
  type = list(
    object({
      # if using data source for route_table_id, 
      # provide route_table tag "Name", else provide route_table_id
      rt                     = string
      destination_cidr_block = string
      #destination_type       = string
      destination_name = string
    })
  )
}

# # route_table_dynamic
# variable "rtd" {
#   type = list(
#     object({
#       # if using data source for vpc_id, 
#       # provide vpc tag "Name", else provide vpc_id directly
#       vpc    = string
#       route  = list(map(string))
#       tags   = map(string)
#     })
#   )
# }

# route_table_association
variable "rta" {
  type = list(
    object({
      # if using data source for subnet_id/route_table_id, 
      # provide subnet/route_table tag "Name", else provide subnet_id/route_table_id
      subnet = string
      #subnet_id   = string
      route_table = string
    })
  )
}

# security_group
variable "sg" {
  type = list(
    object({
      # if using data source for vpc_id, 
      # provide vpc tag "Name", else provide vpc_id
      name        = string
      description = string
      vpc         = string
      #vpc_id      = string
      tags = map(string)
    })
  )
}

# #security_group_rule
# variable "sgr" {
#   type = list(
#     object({
#       description    = string
#       type           = string
#       from_port      = number
#       to_port        = number
#       protocol       = string
#       cidr_block     = list(string)
#       security_group = string
#       # security_group_id = string
#     })
#   )
# }

#security_group_egress_rule
variable "sger" {
  type = list(
    object({
      description    = string
      security_group = string
      #security_group_id = string
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string
      to_port     = number
    })
  )
}

#security_group_ingress_rule
variable "sgir" {
  type = list(
    object({
      description    = string
      security_group = string
      #security_group_id = string
      cidr_ipv4   = string
      from_port   = number
      ip_protocol = string
      to_port     = number
    })
  )
}

variable "iam_role" {
  type = list(
    object({
      name = string
      tags = map(string)
      #policy_arn = set(string)
    })
  )
}

# #iam_role_policy_attachment
# variable "iam_rpa" {
#   type = list(
#     object({
#       role       = string
#       policy_arn = set(string)
#     })
#   )
# }

#iam_role_policy_assignment
variable "iam_rpa" {
  type = object({
    role       = string
    policy_arn = set(string)
  })
}

# iam_instance_profile
variable "iam_i_p" {
  type = list(
    object({
      name = string
      role = string
    })
  )
}

variable "launch_template" {
  type = list(
    object({
      name               = string
      image_id           = string
      instance_type      = string
      vpc_security_group = set(string)
      #vpc_security_group_ids = set(string)
      iam_instance_profile = string
      user_data            = string
      tag_specifications = list(
        object({
          # tags to apply to the resources during launch
          resource_type = string
          # a map of tags to assign to the launch template
          tags = map(string)
        })
      )
    })
  )
}

# loadbalancer target group
variable "lb_tg" {
  type = list(
    object({
      # if using data source for vpc_id, 
      # provide vpc tag "Name", else provide vpc_id
      name = string
      #target_type = string
      port     = number
      protocol = string
      vpc      = string
      #vpc_id   = string
      tags = map(string)
    })
  )
}

# autoscaling_group
variable "asg" {
  type = list(
    object({
      name    = string
      subnets = list(string)
      # id's of subnets in which EC2 instances will reside 
      #vpc_zone_identifier = list(string)
      desired_capacity   = number
      max_size           = number
      min_size           = number
      target_group_names = set(string)
      # target_group_arns   = set(string)
      launch_template_name = string
      # launch_template_id   = string
      tag = list(
        object({
          key                 = string
          value               = string
          propagate_at_launch = bool
        })
      )
    })
  )
}

# autoscaling group policy
variable "asgplc" {
  type = list(
    object({
      name                   = string
      policy_type            = string
      adjustment_type        = string
      autoscaling_group_name = string
      predefined_metric_type = string
      target_value           = number
    })
  )
}

# loadbalancer
variable "lb" {
  type = list(
    object({
      name                 = string
      internal             = bool
      load_balancer_type   = string
      security_group_names = list(string)
      # security_groups    = list(string)
      subnet_names = list(string)
      # subnets            = list(string)
      # access_logs = object({
      #   s3_bucket              = string
      #   s3_prefix              = string
      #   s3_access_logs_enabled = bool
      # })
      tags = map(string)
    })
  )
}

# loadbalancer listener
variable "lb_listener" {
  type = list(
    object({
      load_balancer_name = string
      # load_balancer_arn = string
      port              = number
      protocol          = string
      action_type       = string
      target_group_name = string
      # target_group_arn  = string
      tags = map(string)
    })
  )
}

# # loadbalancer target group attachment
# variable "lb_tga" {
#   type = list(
#     object({
#       target_group_arn = string
#       target_id        = string
#       port             = number
#     })
#   )
# }

# # ec2_with_launch_template
# variable "ec2lt" {
#   type = list(
#     object({
#       subnet_id          = string
#       launch_template_id = string
#       tags               = map(string)
#     })
#   )
# }

# variable "ec2" {
#   type = list(
#     object({
#       name          = string
#       ami           = string
#       instance_type = string
#       subnet_id     = string
#     })
#   )
# }

# # main_route_table
# variable "mrt" {
#   type = list(
#     object({
#       vpc_id         = string
#       route_table_id = string
#     })
#   )
# }

# # variable "drt" {
# #   type = list(
# #     object({
# #       name   = string
# #       vpc_id = string
# #     })
# #   )
# # }







# # #list iam_role_policy_assignment
# # variable "iam_rpa" {
# #   type = list(
# #     object({
# #       role       = string
# #       policy_arn = list(string)
# #     })
# #   )  
# # }