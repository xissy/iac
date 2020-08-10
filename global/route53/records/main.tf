provider "aws" {
  version = "~> 2.21.1"
  region  = "ap-northeast-2"
}

terraform {
  backend "s3" {
    bucket = "taeho-io-iac-terraform-state"
    key    = "global/route53/records/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "hosted_zone" {
  backend = "s3"
  config = {
    bucket = "taeho-io-iac-terraform-state"
    key    = "global/route53/hosted_zones/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "taeho-io-iac-terraform-state"
    key    = "production/ec2/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
