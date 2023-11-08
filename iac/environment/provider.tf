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
  region     = "eu-central-1"
  access_key = "AKIA3GX2ZTPUKVUZCE2F"
  secret_key = "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"
}
