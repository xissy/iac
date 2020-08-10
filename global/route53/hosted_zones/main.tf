provider "aws" {
  version = "~> 2.21.1"
  region  = "ap-northeast-2"
}

terraform {
  backend "s3" {
    bucket = "taeho-io-iac-terraform-state"
    key    = "global/route53/hosted_zones/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
