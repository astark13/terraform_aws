resource "aws_instance" "ec2_with_launch_template" {
  count         = var.ec2lt == null ? 0 : 1
  subnet_id     = var.ec2lt.subnet_id
  tags          = var.ec2lt.tags
  launch_template {
    id      = var.ec2lt.launch_template_id
    version = "$Latest"
  }
}