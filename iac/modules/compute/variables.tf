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
  #default = null
  })
  default = null
} 

# variable "tags" {
#   default = null
# }