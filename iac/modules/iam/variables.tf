variable "iam_role" {
  type = object({
    name       = string
    tags       = map(string)
    #policy_arn = set(string)
  })
  default = null
}

#iam_role_policy_assignment
variable "iam_rpa" {
  type = object({
    role       = string
    policy_arn = set(string)
  })
  default = null
}

# iam_instance_profile
variable "iam_i_p" {
  type = object({
    name = string
    role = string
  })
  default = null
}

