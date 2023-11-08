# terraform {
#   backend "s3" {
#     bucket         = "adrians-terraform-bucket"
#     key            = "terraform.tfstate"
#     region         = "eu-central-1"
#     dynamodb_table = "terraform-state-locking"
#   }
# }