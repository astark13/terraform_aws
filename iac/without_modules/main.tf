resource "aws_vpc" "terraform_vpc" {
  cidr_block = "10.0.0.0/26"
}

resource "aws_subnet" "terraform_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.0.0.0/27"
}

resource "aws_internet_gateway" "ig_terraform_vpc" {
  vpc_id = aws_vpc.terraform_vpc.id
  tags = {
    Name = "Terraform"
  }
}

resource "aws_default_route_table" "test" {
  default_route_table_id = aws_vpc.terraform_vpc.default_route_table_id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = "10.0.0.0/26"
    gateway_id = "local"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_terraform_vpc.id
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.terraform_vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_instance" "web" {
#   ami           = "ami-04376654933b081a7"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.terraform_subnet.id
#   user_data     = <<EOF
# #!/bin/bash
# # Use this for your user data (script from top to bottom)
# # install httpd (Linux 2 version)
# yum update -y
# yum install -y httpd
# systemctl start httpd
# systemctl enable httpd
# echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
# systemctl restart httpd
# EOF
#   tags = {
#     name = "Webserver"
#   }
# }

# resource "aws_eip" "webserver_eip" {
#   domain   = "vpc"
#   instance = aws_instance.web.id
# }

resource "aws_launch_template" "lt_linux_t2_micro" {
  name          = "linux_t2_micro"
  image_id      = "ami-04376654933b081a7"
  instance_type = "t2.micro"
}