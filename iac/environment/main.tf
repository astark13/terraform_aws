# needs to be run alone, before subnet creation
module "vpc" {
  for_each = { for vpc in var.vpc : vpc.cidr_block => vpc }
  source   = "../modules/network/"
  vpc      = each.value
}

# this module needs the vpc_id of the previously created vpc !!!
module "subnet" {
  for_each = { for subnet in var.subnet : subnet.tags.Name => subnet }
  source   = "../modules/network/"
  subnet   = each.value
  depends_on = [
    module.vpc
  ]
}

module "internet_gateway" {
  for_each = { for ig in var.ig : ig.tags.Name => ig }
  source   = "../modules/network"
  ig       = each.value
  depends_on = [
    module.vpc
  ]
}

module "route_table" {
  for_each = { for rt in var.rt : rt.tags.Name => rt }
  source   = "../modules/network"
  rt       = each.value
  depends_on = [
    module.vpc,
    module.internet_gateway
  ]
}

module "main_route_table_association" {
  for_each = { for mrt in var.mrt : mrt.route_table_id => mrt }
  source   = "../modules/network"
  mrt      = each.value
  depends_on = [
    module.vpc,
    module.internet_gateway,
    module.route_table
  ]
}

module "security_group" {
  for_each = { for sg in var.sg : sg.name => sg }
  source   = "../modules/network"
  sg       = each.value
  depends_on = [
    module.vpc
  ]
}

# module "launch_template" {
#   for_each        = { for launch_template in var.launch_template : launch_template.name => launch_template }
#   source          = "../modules/compute"
#   launch_template = each.value
#   tags            = var.tags
#   depends_on = [
#     module.default_security_group
#   ]
# }

# # # you need to specify the subnet_id in terraform.tfvars before running this module
# # module "ec2" {
# #   for_each = { for ec2 in var.ec2 : ec2.name => ec2 }
# #   source   = "../modules/compute"
# #   ec2      = each.value
# #   tags     = var.tags
# #   depends_on = [
# #     module.vpc,
# #     module.subnet,
# #     module.internet_gateway,
# #     module.default_route_table,
# #     module.default_security_group ]
# # }

# # # you need to specify the instance_id terraform.tfvars before running this module
# # module "eip" {
# #   for_each = { for eip in var.eip : eip.instance_id => eip }
# #   source   = "../modules/network"
# #   eip      = each.value
# #   tags     = var.tags
# #   depends_on = [
# #     module.ec2
# #   ]
# # }

# # # # # # resource "aws_launch_template" "lt_linux_t2_micro" {
# # # # # #   name          = "linux_t2_micro"
# # # # # #   image_id      = "ami-04376654933b081a7"
# # # # # #   instance_type = "t2.micro"
# # # # # # }