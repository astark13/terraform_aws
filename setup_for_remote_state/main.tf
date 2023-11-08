resource "aws_s3_bucket" "terraform-bucket" {
  bucket = var.bucket_name

  tags =  var.bucket_tags
}

resource "aws_dynamodb_table" "terraform-state-locking" {
  name = var.dynamodb_table_name
  # hardcoded values are mandatory
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}