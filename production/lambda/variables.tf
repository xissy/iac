
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "taeho-io-iac-terraform-state"
    key    = "production/vpc/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
