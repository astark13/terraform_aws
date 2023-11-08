data "aws_vpc" "sg" {
  count = var.sg == null ? 0 : 1
  id    = var.sg.vpc_id
}

resource "aws_default_security_group" "default" {
  count  = var.sg == null ? 0 : 1
  vpc_id = data.aws_vpc.sg[0].id

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
  tags = var.tags
}