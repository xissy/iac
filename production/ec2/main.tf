provider "aws" {
  version = "~> 2.57"
  region  = "ap-northeast-2"
}

terraform {
  backend "s3" {
    bucket = "taeho-io-iac-terraform-state"
    key    = "production/ec2/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
