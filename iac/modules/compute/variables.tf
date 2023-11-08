variable "ec2" {
  type = object({
    ami           = string
    instance_type = string
    subnet_id     = string
  })
  default = null
}

variable "tags" {
  default = null
}