terraform {
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.39.0"
    }
  }
  backend "s3" {
    bucket = "terraform-advanced-bucket"
    dynamodb_table = "terraform-advanced-table"
    key = "terraform.tfstate"
    region = "ap-south-1"
  }

}