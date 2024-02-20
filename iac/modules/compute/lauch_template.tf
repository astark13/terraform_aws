resource "aws_launch_template" "terraform_lauch_template" {
  count = var.launch_template == null ? 0 : 1
  name = var.launch_template.name
  image_id = var.launch_template.image_id
  instance_type = var.launch_template.instance_type
  vpc_security_group_ids = var.launch_template.vpc_security_group_ids
  #user_data = filebase64("${path.module}/example.sh")
  tags          = var.tags
}