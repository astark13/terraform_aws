terraform {
  backend "s3" {
    bucket         = "katjas-terraform.tfstate-bucket"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}
