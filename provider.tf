# Using AWS s3 as the backend of this function
# Use Terraform verison 13+, (actually 1.0.11)

terraform {
  backend "s3" {
    bucket = "terraform-state-scb-bucket"
    key    = "wm/terraform.tfstate"
    region = "ap-southeast-1"
  }
  required_version = ">= 0.13.0"
}

provider "aws" {
  region = "ap-southeast-1"
}