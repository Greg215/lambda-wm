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