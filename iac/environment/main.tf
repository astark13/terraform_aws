# needs to be run alone, before subnet creation
module "vpc" {
  for_each = { for vpc in var.vpc : vpc.cidr_block => vpc }
  source   = "../modules/network/"
  vpc      = each.value
  #uncomment in case you want to
  # use global variables
  # project  = var.project
  # environment = var.environment
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
  source   = "../modules/network/"
  ig       = each.value
  depends_on = [
    module.vpc
  ]
}

# elastic ip
module "eip" {
  for_each = { for eip in var.eip : eip.tags.Name => eip }
  source   = "../modules/network/"
  eip      = each.value
  depends_on = [
    module.vpc
  ]
}

module "nat_gateway" {
  for_each = { for ngw in var.ngw : ngw.tags.Name => ngw }
  source   = "../modules/network/"
  ngw      = each.value
  depends_on = [
    module.subnet,
    module.eip
  ]
}

module "route_table" {
  for_each = { for rt in var.rt : rt.tags.Name => rt }
  source   = "../modules/network/"
  rt       = each.value
  depends_on = [
    module.vpc,
    module.internet_gateway,
    module.nat_gateway
  ]
}


# module "route_table_local_route" {
#   for_each    = { for rt_l_r in var.rt_l_r: rt_l_r.rt => rt_l_r }
#   source      = "../modules/network/"
#   rt_l_r      = each.value
#   depends_on = [
#     module.route_table
#   ]
# }

module "route_table_ngw_route" {
  for_each = { for rt_ngw_r in var.rt_ngw_r : rt_ngw_r.rt => rt_ngw_r }
  source   = "../modules/network/"
  rt_ngw_r = each.value
  depends_on = [
    module.route_table
  ]
}

module "route_table_igw_route" {
  for_each = { for rt_igw_r in var.rt_igw_r : rt_igw_r.rt => rt_igw_r }
  source   = "../modules/network/"
  rt_igw_r = each.value
  depends_on = [
    module.route_table
  ]
}


# # this module needs the internet/nat gateway id !!!
# module "route_table_dynamic" {
#   for_each = { for rtd in var.rtd : rtd.tags.Name => rtd }
#   source   = "../modules/network/"
#   rtd      = each.value
#   depends_on = [
#     module.vpc,
#     module.internet_gateway
#   ]
# }

# this module needs the internet gateway id !!!
module "route_table_association" {
  for_each = { for rta in var.rta : rta.subnet => rta }
  source   = "../modules/network/"
  rta      = each.value
  depends_on = [
    module.subnet,
    module.internet_gateway,
    module.nat_gateway,
    module.route_table
  ]
}

module "security_group" {
  for_each = { for sg in var.sg : sg.name => sg }
  source   = "../modules/network/"
  sg       = each.value
  depends_on = [
    module.vpc
  ]
}

# # this module needs the security group id/name !!!
# # Using the "All trafic" option doesn't work sometimes!!!!
# # Try specifing the actual port you wanna access (e.g. 443)!!!
# module "security_group_rule" {
#   for_each = { for sgr in var.sgr : sgr.description => sgr }
#   source   = "../modules/network/"
#   sgr      = each.value
#   depends_on = [
#     module.security_group
#   ]
# }

# this module needs the security group id/name !!!
# Using the "All trafic" option doesn't work sometimes!!!!
# Try specifing the actual port you wanna access (e.g. 443)!!!
module "security_group_egress_rule" {
  for_each = { for sger in var.sger : sger.description => sger }
  source   = "../modules/network/"
  sger     = each.value
  depends_on = [
    module.security_group
  ]
}

# this module needs the security group id/name !!!
# Using the "All trafic" option doesn't work sometimes!!!!
# Try specifing the actual port you wanna access (e.g. 443)!!!
module "security_group_ingress_rule" {
  for_each = { for sgir in var.sgir : sgir.description => sgir }
  source   = "../modules/network/"
  sgir     = each.value
  depends_on = [
    module.security_group
  ]
}

module "iam_role" {
  for_each = { for iam_role in var.iam_role : iam_role.name => iam_role }
  source   = "../modules/iam/"
  iam_role = each.value
}

# # # module "iam_rpa" {
# # #   for_each = { for iam_rpa in var.iam_rpa : iam_rpa.role => iam_rpa }
# # #   source   = "../modules/iam/"
# # #   iam_rpa  = each.value
# # #   depends_on = [
# # #     module.iam_role
# # #   ]
# # # }

resource "aws_iam_role_policy_attachment" "test-attach" {
  for_each   = var.iam_rpa.policy_arn
  role       = var.iam_rpa.role
  policy_arn = each.value
  depends_on = [module.iam_role]
}

# iam_instance_profile
module "iam_i_p" {
  for_each = { for iam_i_p in var.iam_i_p : iam_i_p.name => iam_i_p }
  source   = "../modules/iam/"
  iam_i_p  = each.value
  depends_on = [
    module.iam_role
  ]
}

# if you want to assign a role to an EC2 instance,
# you need to create a "iam_instance_profile" first!!!
# Create an EC2 instance manually and check if everything is fine 
#(e.g. test the ami to if if SSM works )
module "launch_template" {
  for_each        = { for launch_template in var.launch_template : launch_template.name => launch_template }
  source          = "../modules/compute/"
  launch_template = each.value
  depends_on = [
    module.security_group,
    module.iam_i_p
  ]
}

module "loadbalancer_target_group" {
  for_each = { for lb_tg in var.lb_tg : lb_tg.name => lb_tg }
  source   = "../modules/compute/"
  lb_tg    = each.value
  depends_on = [
    module.vpc
  ]
}

# install "stress"
# https://cloudkatha.com/how-to-install-stress-on-amazon-linux-2023/?utm_content=cmp-true
module "autoscaling_group" {
  for_each = { for asg in var.asg : asg.name => asg }
  source   = "../modules/compute/"
  asg      = each.value
  depends_on = [
    module.subnet,
    module.route_table_association,
    module.loadbalancer_target_group,
    module.launch_template
  ]
}

module "autoscaling_group_policy" {
  for_each = { for asgplc in var.asgplc : asgplc.name => asgplc }
  source   = "../modules/compute/"
  asgplc   = each.value
  depends_on = [
    module.autoscaling_group
  ]
}

module "loadbalancer" {
  for_each = { for lb in var.lb : lb.name => lb }
  source   = "../modules/compute/"
  lb       = each.value
  depends_on = [
    module.security_group,
    module.subnet
  ]
}

module "loadbalancer_listener" {
  for_each    = { for lb_listener in var.lb_listener : lb_listener.tags.Name => lb_listener }
  source      = "../modules/compute/"
  lb_listener = each.value
  depends_on = [
    module.loadbalancer,
    module.loadbalancer_target_group
  ]
}

# # # ##################################

# # # # module "loadbalancer_target_group_attachment" {
# # # #   for_each = { for lb_tga in var.lb_tga : lb_tga.target_group_arn => lb_tga}
# # # #   source = "../modules/compute/"
# # # #   lb_tga = each.value
# # # #   depends_on = [ 
# # # #     module.loadbalancer_target_group 
# # # #   ]
# # # # }

# # # # # # # module "autoscaling_policy" {
# # # # # # #   for_each = { for asgplc in var.asgplc : asgplc.name => asgplc }
# # # # # # #   source = "../modules/compute/"
# # # # # # #   asgplc = each.value
# # # # # # #   depends_on = [ 
# # # # # # #     module.autoscaling_group
# # # # # # #   ]
# # # # # # # }

# # # # # # resource "aws_lb_target_group" "test" {
# # # # # #   name     = "tf-example-lb-tg"
# # # # # #   port     = 80
# # # # # #   protocol = "HTTP"
# # # # # #   vpc_id   = "vpc-049dc5ebbbdbe4332"
# # # # # # }

# # # # # # # # # you need to specify the subnet_id and launch_template_id in terraform.tfvars
# # # # # # # # # before running this module which creates an EC2 instance using a launch template
# # # # # # # # module "ec2lt" {
# # # # # # # #   for_each = { for ec2lt in var.ec2lt : ec2lt.tags.Name => ec2lt }
# # # # # # # #   source   = "../modules/compute"
# # # # # # # #   ec2lt    = each.value
# # # # # # # #   # tags     = var.tags
# # # # # # # #   depends_on = [
# # # # # # # #     module.launch_template
# # # # # # # #     #   module.vpc,
# # # # # # # #     #   module.subnet,
# # # # # # # #     #   module.internet_gateway,
# # # # # # # #     #   module.default_route_table,
# # # # # # # #     #   module.default_security_group 
# # # # # # # #   ]
# # # # # # # # }

# # # # # # # # # you need to specify the subnet_id in terraform.tfvars before running this module
# # # # # # # # module "ec2" {
# # # # # # # #   for_each = { for ec2 in var.ec2 : ec2.name => ec2 }
# # # # # # # #   source   = "../modules/compute"
# # # # # # # #   ec2      = each.value
# # # # # # # #   tags     = var.tags
# # # # # # # #   depends_on = [
# # # # # # # #     module.vpc,
# # # # # # # #     module.subnet,
# # # # # # # #     module.internet_gateway,
# # # # # # # #     module.default_route_table,
# # # # # # # #     module.default_security_group ]
# # # # # # # # }

# # # # # # # # # this module needs the route table id !!!
# # # # # # # # It's important to note that a VPC can have multiple route tables,
# # # # # # # # but only one main route table. While additional route tables
# # # # # # # # can be associated with specific subnets,
# # # # # # # # the main route table remains the default route table for all non-specified subnets.
# # # # # # # # module "main_route_table_association" {
# # # # # # # #   for_each = { for mrt in var.mrt : mrt.route_table_id => mrt }
# # # # # # # #   source   = "../modules/network"
# # # # # # # #   mrt      = each.value
# # # # # # # #   depends_on = [
# # # # # # # #     module.vpc,
# # # # # # # #     module.internet_gateway,
# # # # # # # #     module.route_table
# # # # # # # #   ]
# # # # # # # # }

# # # # # # # # module "iam_role_policy_attachment" {
# # # # # # # #   for_each = { for iam_rpa in var.iam_rpa : iam_rpa.role => iam_rpa}
# # # # # # # #   source = "../modules/iam"
# # # # # # # #   iam_rpa = each.value
# # # # # # # #   depends_on = [ 
# # # # # # # #     module.iam_role 
# # # # # # # #   ]  
# # # # # # # # }

