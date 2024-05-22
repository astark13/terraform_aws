resource "aws_instance" "web" {
  count         = var.ec2 == null ? 0 : 1
  ami           = var.ec2.ami
  instance_type = var.ec2.instance_type
  subnet_id     = var.ec2.subnet_id
  user_data     = file("${path.module}/install_apache_and_stress.sh")
  #tags          = var.tags
}