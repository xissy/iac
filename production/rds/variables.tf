
data "terraform_remote_state" "ec2" {
  backend = "s3"
  config = {
    bucket = "taeho-io-iac-terraform-state"
    key    = "production/ec2/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "taeho-io-iac-terraform-state"
    key    = "production/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

variable "home_cidr" {
  type    = string
  default = "211.177.118.6/32"
}
