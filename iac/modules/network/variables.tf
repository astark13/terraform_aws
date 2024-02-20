# variable "tags" {
#   default = null
# }

variable "vpc" {
  type = object({
    cidr_block = string
    tags       = map(string)
  })
  default = null
}

variable "subnet" {
  type = object({
    vpc_id            = string
    availability_zone = string
    newbits           = number
    netnum            = number
    tags              = map(string)
  })
  default = null
}

variable "ig" {
  type = object({
    vpc_id = string
    tags   = map(string)
  })
  default = null
}

variable "rt" {
  type = object({
    vpc_id = string
    route  = list(map(string))
    tags   = map(string)
  })
  default = null
}

#main_route_table
variable "mrt" {
  type = object({
    vpc_id         = string
    route_table_id = string
  })
  default = null
}

variable "drt" {
  type = object({
    vpc_id = string
  })
  default = null
}

variable "sg" {
  type = object({
    vpc_id = string
  })
  default = null
}

variable "eip" {
  type = object({
    instance_id = string
  })
  default = null
}

