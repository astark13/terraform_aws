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

variable "ig" {
  type = list(
    object({
      vpc_id = string
      tags   = map(string)
    })
  )
}

variable "rt" {
  type = list(
    object({
      vpc_id = string
      route  = list(map(string))
      tags   = map(string)
    })
  )
}

#main_route_table
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

variable "sg" {
  type = list(
    object({
      name        = string
      description = string
      vpc_id      = string
    })
  )
}

variable "launch_template" {
  type = list(
    object({
      name                   = string
      image_id               = string
      instance_type          = string
      vpc_security_group_ids = set(string)
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

variable "eip" {
  type = list(
    object({
      instance_id = string
    })
  )
}