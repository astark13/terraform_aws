variable "vpc" {
  type = object({
    cidr_block = string
  })
  default = null
}

variable "subnet" {
  type = object({
    name              = string
    vpc_id            = string
    availability_zone = string
    newbits           = number
    netnum            = number
  })
  default = null
}

variable "ig" {
  type = object({
    vpc_id = string
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

variable "tags" {
  default = null
}