resource "aws_iam_role" "iam_role" {
  count = var.iam_role == null ? 0 : 1
  name  = var.iam_role.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = var.iam_role.tags
}

# resource "aws_iam_role_policy_attachment" "iam-rpa" {
#   for_each   = var.iam_role.policy_arn
#   role       = var.iam_role.name
#   policy_arn = each.value
#   depends_on = [ aws_iam_role.iam_role ]
# }
