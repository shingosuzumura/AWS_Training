provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
    backend "s3" {
    bucket = "remote-backend-suzumura"
    key    = "terraform/terraform.tfs"
    region = "us-east-1"
  }
}
