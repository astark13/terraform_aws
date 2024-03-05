variable "iam_role" {
  type = object({
    name       = string
    tags       = map(string)
    policy_arn = set(string)
  })
  default = null
}