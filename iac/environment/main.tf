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

# you need to specify the instance_id terraform.tfvars before running this module
module "eip" {
  for_each = { for eip in var.eip : eip.tags.Name => eip }
  source   = "../modules/network"
  eip      = each.value
  depends_on = [
    module.vpc
  ]
}

module "nat_gateway" {
  for_each   = { for ngw in var.ngw : ngw.tags.Name => ngw }
  source     = "../modules/network"
  ngw        = each.value
  depends_on = [
    module.internet_gateway,
    module.eip
  ]
}

# this module needs the internet gateway id !!!
module "route_table" {
  for_each = { for rt in var.rt : rt.tags.Name => rt }
  source   = "../modules/network"
  rt       = each.value
  depends_on = [
    module.vpc,
    module.internet_gateway
  ]
}

# this module needs the internet gateway id !!!
module "route_table_association" {
  for_each = { for rta in var.rta : rta.subnet_id => rta }
  source   = "../modules/network"
  rta       = each.value
  depends_on = [
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

# this module needs the security group id !!!
module "security_group_rule" {
  for_each = { for sgr in var.sgr : sgr.description => sgr }
  source   = "../modules/network"
  sgr      = each.value
  depends_on = [
    module.security_group
  ]
}


# # this module needs the route table id !!!
# It's important to note that a VPC can have multiple route tables,
# but only one main route table. While additional route tables
# can be associated with specific subnets,
# the main route table remains the default route table for all non-specified subnets.
# module "main_route_table_association" {
#   for_each = { for mrt in var.mrt : mrt.route_table_id => mrt }
#   source   = "../modules/network"
#   mrt      = each.value
#   depends_on = [
#     module.vpc,
#     module.internet_gateway,
#     module.route_table
#   ]
# }

# module "launch_template" {
#   for_each        = { for launch_template in var.launch_template : launch_template.name => launch_template }
#   source          = "../modules/compute"
#   launch_template = each.value
#   depends_on = [
#     module.security_group
#   ]
# }

# # # # you need to specify the subnet_id in terraform.tfvars before running this module
# # # module "ec2" {
# # #   for_each = { for ec2 in var.ec2 : ec2.name => ec2 }
# # #   source   = "../modules/compute"
# # #   ec2      = each.value
# # #   tags     = var.tags
# # #   depends_on = [
# # #     module.vpc,
# # #     module.subnet,
# # #     module.internet_gateway,
# # #     module.default_route_table,
# # #     module.default_security_group ]
# # # }

