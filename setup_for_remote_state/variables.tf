variable "aws_region" {
  type = string
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