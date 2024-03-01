variable "iam_role" {
  type = object({
    name = string
    tags = map(string)
  })
  default = null
}