variable "aws_region" {
  type = string
}

variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}

variable "bucket_name" {
  type = string
}

variable "bucket_tags" {
  type = map(string)
}

variable "dynamodb_table_name" {
  type = string
}