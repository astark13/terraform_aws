# UNCOMMENT in case you want to
# use global variables
# variable "environment" {
#   type = string
#   default = null
# }

variable "vpc" {
  type = object({
    cidr_block = string
    # COMMENT in case global variables are used
    tags       = map(string)
  })
  default = null
}

# variable "subnet" {
#   type = object({
#     # if using data source for vpc_id, 
#     # provide vpc tag "Name", else provide vpc_id directly
#     vpc_id                  = string
#     availability_zone       = string
#     newbits                 = number
#     netnum                  = number
#     map_public_ip_on_launch = bool
#     tags                    = map(string)
#     #vpc_name_tag            = string
#   })
#   default = null
# }

variable "subnet" {
  type = object({
    # if using data source for vpc_id, 
    # provide vpc tag "Name", else provide vpc_id directly
    vpc                     = string
    availability_zone       = string
    newbits                 = number
    netnum                  = number
    map_public_ip_on_launch = bool
    tags                    = map(string)
    #vpc_name_tag            = string
  })
  default = null
}

# #internet_gateway
# variable "ig" {
#   type = object({
#     vpc_id = string
#     tags   = map(string)
#   })
#   default = null
# }

#internet_gateway
variable "ig" {
  type = object({
    vpc = string
    tags   = map(string)
  })
  default = null
}

#elastic_ip
variable "eip" {
  type = object({
    domain = string
    tags   = map(string)
  })
  default = null
}


# #nat_gateway
# variable "ngw" {
#   type = object({
#     allocation_id = string
#     subnet_id     = string
#     tags          = map(string)
#   })
#   default = null
# }

#nat_gateway
variable "ngw" {
  type = object({
    eip    = string
    subnet = string
    tags   = map(string)
  })
  default = null
}


#route_table_dynamic
variable "rtd" {
  type = object({
    vpc_id = string
    route  = list(map(string))
    tags   = map(string)
  })
  default = null
}

#route_table
variable "rt" {
  type = object({
    vpc    = string
    tags   = map(string)
  })
  default = null
}

#route_table_local_route
variable "rt_l_r" {
  type = object({
    rt                     = string
    destination_cidr_block = string
  })
  default = null
}

#route_table_ngw_route
variable "rt_ngw_r" {
  type = object({
    rt                     = string
    destination_cidr_block = string
    #destination_type       = string
    destination_name       = string
  })
  default = null
}

#route_table_igw_route
variable "rt_igw_r" {
  type = object({
    rt                     = string
    destination_cidr_block = string
    #destination_type       = string
    destination_name       = string
  })
  default = null
}

#route_table_association
variable "rta" {
  type = object({
    subnet          = string
    #subnet_id       = string
    route_table     = string
    #route_table_id  = string
  })
  default = null
}

#security_group
variable "sg" {
  type = object({
    name        = string
    description = string
    vpc         = string
    #vpc_id      = string
    tags   = map(string)
  })
  default = null
}

#security_group_rule
variable "sgr" {
  type = object({
    description       = string
    type              = string
    from_port         = number
    to_port           = number
    protocol          = string
    cidr_block        = list(string)
    security_group    = string
    #security_group_id = string
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

#default_security_group
variable "dsg" {
  type = object({
    vpc_id = string  
  })
  default = null
}

#default_route_table
variable "drt" {
  type = object({
    vpc_id = string
  })
  default = null
}
