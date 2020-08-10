
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

data "terraform_remote_state" "customdomainnames" {
  backend = "s3"
  config = {
    bucket = "taeho-io-iac-terraform-state"
    key    = "production/apigateway/customdomainnames/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

locals {
  zone_ids = {
    taeho_io = data.terraform_remote_state.hosted_zone.outputs.taeho_io_zone_id
  }
}

