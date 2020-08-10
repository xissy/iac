provider "aws" {
  alias   = "seoul"
  version = "~> 2.21.1"
  region  = "ap-northeast-2"
}

terraform {
  backend "s3" {
    bucket = "taeho-io-iac-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
