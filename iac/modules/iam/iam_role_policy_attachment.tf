
# resource "aws_iam_role_policy_attachment" "test-attach" {
#   for_each   = var.iam_z.policy_arn
#   role       = var.iam_z.role
#   policy_arn = each.value
# }