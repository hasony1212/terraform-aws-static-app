terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.1.0"
    }
  }
  required_version = ">=1.2.0"
}



provider "aws" {
  region = "us-east-1"
}

#Setup S3 backend, config is setup using the qa_backend.tfvars file. 
terraform {
  backend "s3" {}
}


resource "random_string" "random" {
  length  = 2
  upper   = false
  special = false
}

