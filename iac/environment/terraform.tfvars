tags = {
  "Environment" = "dev"
  "Name"        = "Terraform"
}

vpc = [{
  cidr_block = "10.0.0.0/26"
  }
]

subnet = [
  {
    name              = "subnet1"
    vpc_id            = "vpc-06cd1506f83d3c4e2"
    availability_zone = "eu-central-1a"
    newbits           = 2
    netnum            = 0
  },

  {
    name              = "subnet2"
    vpc_id            = "vpc-06cd1506f83d3c4e2"
    availability_zone = "eu-central-1a"
    newbits           = 2
    netnum            = 1
  }
]

ig = [
  {
    name   = "ig_1"
    vpc_id = "vpc-06cd1506f83d3c4e2"
  }
]

drt = [
  {
    name   = "def_route_table_1"
    vpc_id = "vpc-06cd1506f83d3c4e2"
  }
]

sg = [
  {
    name   = "security_group_1"
    vpc_id = "vpc-06cd1506f83d3c4e2"
  }
]

ec2 = [
  {
    name          = "webserver_1"
    ami           = "ami-04376654933b081a7"
    instance_type = "t2.micro"
    subnet_id     = "subnet-0f27a6ce4993fd8b5"
  }
]

eip = [
  {
    instance_id = "i-06d2b1f28095d3822"
  }
]



