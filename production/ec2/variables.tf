
variable "keypair" {
  default = "kp-taeho-aws"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "taeho-io-iac-terraform-state"
    key    = "production/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

locals {
  bastion_host = {
    vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id
    az     = data.terraform_remote_state.vpc.outputs.bastion_host_az
    subnet = data.terraform_remote_state.vpc.outputs.bastion_host_subnet
  }
}
