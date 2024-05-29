terraform {
  backend "s3" {
    bucket                   = "project-a-terraform.tfstate-bucket"
    key                      = "terraform/terraform.tfstate"
    region                   = "eu-central-1"
    dynamodb_table           = "terraform-state-locking"
    encrypt                  = true
  }
}
