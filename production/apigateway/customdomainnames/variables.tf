
data "terraform_remote_state" "acm" {
  backend = "s3"
  config = {
    bucket = "taeho-io-iac-terraform-state"
    key    = "management/acm/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
