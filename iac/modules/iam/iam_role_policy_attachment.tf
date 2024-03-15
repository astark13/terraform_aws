
# resource "aws_iam_role_policy_attachment" "test-attach" {
#   for_each   = var.iam_rpa.policy_arn
#   role       = var.iam_rpa.role
#   policy_arn = each.value
# }

# resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
#   role       = var.iam_rpa.role
#   count      = length(var.iam_rpa.policy_arn)
#   policy_arn = var.iam_rpa.policy_arn[count.index]
# }