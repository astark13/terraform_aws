variable "aws_region" {
  type = string
}

variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}


# variable "tags" {
#   type = map(string)
# }

variable "vpc" {
  type = list(
    object({
      cidr_block = string
      tags       = map(string)
    })
  )
}

variable "subnet" {
  type = list(
    object({
      vpc_id            = string
      availability_zone = string
      newbits           = number
      netnum            = number
      tags              = map(string)
    })
  )
}

# internet_gateway
variable "ig" {
  type = list(
    object({
      vpc_id = string
      tags   = map(string)
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

# nat_gateway
variable "ngw" {
  type = list(
    object({
      allocation_id = string
      subnet_id     = string
      tags          = map(string)
    })
  )
}

# route_table
variable "rt" {
  type = list(
    object({
      vpc_id = string
      route  = list(map(string))
      tags   = map(string)
    })
  )
}

# route_table_association
variable "rta" {
  type = list(
    object({
      subnet_id      = string
      route_table_id = string
    })
  )
}

# security_group
variable "sg" {
  type = list(
    object({
      name        = string
      description = string
      vpc_id      = string
    })
  )
}

#security_group_rule
variable "sgr" {
  type = list(
    object({
      description       = string
      type              = string
      from_port         = number
      to_port           = number
      protocol          = string
      cidr_block        = list(string)
      security_group_id = string
    })
  )
}

variable "iam_role" {
  type = list(
    object({
      name = string
      tags = map(string)
    })
  )
}


# main_route_table
variable "mrt" {
  type = list(
    object({
      vpc_id         = string
      route_table_id = string
    })
  )
}

# variable "drt" {
#   type = list(
#     object({
#       name   = string
#       vpc_id = string
#     })
#   )
# }

variable "launch_template" {
  type = list(
    object({
      name                   = string
      image_id               = string
      instance_type          = string
      vpc_security_group_ids = set(string)
      user_data              = string
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

variable "ec2" {
  type = list(
    object({
      name          = string
      ami           = string
      instance_type = string
      subnet_id     = string
    })
  )
}