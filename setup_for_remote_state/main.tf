##########################################################################
# https://developer.hashicorp.com/terraform/language/settings/backends/s3#
##########################################################################

resource "aws_s3_bucket" "terraform_bucket" {
  bucket = var.bucket_name
  lifecycle {
    prevent_destroy = true
  }
  tags = var.bucket_tags
}

data "aws_s3_bucket" "terraform_bucket" {
  bucket = var.bucket_name
  depends_on = [
    aws_s3_bucket.terraform_bucket
  ]
}

resource "aws_s3_bucket_versioning" "versioning_terraform_bucket" {
  bucket = data.aws_s3_bucket.terraform_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse_terraform_bucket" {
  bucket = data.aws_s3_bucket.terraform_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_locking" {
  name = var.dynamodb_table_name
  # hardcoded values are mandatory
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}