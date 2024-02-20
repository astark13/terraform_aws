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
    vpc_security_group_ids = set(string)
  })
  default = null
}

variable "tags" {
  default = null
}