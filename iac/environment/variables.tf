variable "tags" {
  type = map(string)
}

variable "vpc" {
  type = list(
    object({
      cidr_block = string
    })
  )
}

variable "subnet" {
  type = list(
    object({
      name              = string
      vpc_id            = string
      availability_zone = string
      newbits           = number
      netnum            = number
    })
  )
}

variable "ig" {
  type = list(
    object({
      name   = string
      vpc_id = string
    })
  )
}

variable "drt" {
  type = list(
    object({
      name   = string
      vpc_id = string
    })
  )
}

variable "sg" {
  type = list(
    object({
      name   = string
      vpc_id = string
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