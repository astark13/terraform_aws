# resource "aws_launch_template" "launch_template" {
#   count                  = var.launch_template == null ? 0 : 1
#   name                   = var.launch_template.name
#   image_id               = var.launch_template.image_id
#   instance_type          = var.launch_template.instance_type
#   vpc_security_group_ids = var.launch_template.vpc_security_group_ids
#   iam_instance_profile   {
#     name = var.launch_template.iam_instance_profile
#   }  
#   user_data              = filebase64("${path.module}/${var.launch_template.user_data}")
#   dynamic "tag_specifications" {
#     for_each = var.launch_template.tag_specifications
#     content {
#       # available resource types values:
#       # instance | volume | network-interface | spot-instances-request
#       resource_type = tag_specifications.value.resource_type
#       tags= tag_specifications.value.tags
#     }
#   } 
# }  


##################################
# the code below is configured to create these resources as part
# of the desired architecture in a SINGLE "terraform apply"
##################################

data "aws_security_group" "lt" {
  for_each = var.launch_template.vpc_security_group
  tags  = {
    Name = "${each.key}"
  }
}

locals {
  security_group_ids = [for vpc_security_group in data.aws_security_group.lt : vpc_security_group.id]
}

resource "aws_launch_template" "launch_template" {
  name                   = var.launch_template.name
  image_id               = var.launch_template.image_id
  instance_type          = var.launch_template.instance_type
  vpc_security_group_ids = local.security_group_ids
  iam_instance_profile   {
    name = var.launch_template.iam_instance_profile
  }  
  user_data              = filebase64("${path.module}/${var.launch_template.user_data}")
  dynamic "tag_specifications" {
    for_each = var.launch_template.tag_specifications
    content {
      # available resource types values:
      # instance | volume | network-interface | spot-instances-request
      resource_type = tag_specifications.value.resource_type
      tags= tag_specifications.value.tags
    }
  } 
}  