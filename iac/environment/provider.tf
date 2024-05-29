terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# configure the aws provider
provider "aws" {
  region     = var.aws_region
  shared_credentials_files = ["/home/stark/.aws/credentials"]
  default_tags {
    tags = {
      Origin      = "Terraform"
      Environment = "Dev"
      Project     = "ProjectA"
      Owner       = "Adi"
    }
  }
}