resource "aws_iam_instance_profile" "test_profile" {
  count = var.iam_i_p == null ? 0 : 1
  name  = var.iam_i_p.name
  role  = var.iam_i_p.role
}