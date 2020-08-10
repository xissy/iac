
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.44.0"

  name = "vpc-taeho-io-production"
  cidr = "20.10.0.0/16"

  azs              = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  private_subnets  = ["20.10.1.0/24", "20.10.2.0/24", "20.10.3.0/24"]
  public_subnets   = ["20.10.11.0/24", "20.10.12.0/24", "20.10.13.0/24"]
  database_subnets = ["20.10.21.0/24", "20.10.22.0/24", "20.10.23.0/24"]

  create_database_subnet_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  manage_default_network_acl = true

  enable_vpn_gateway = true

  tags = {
    Environment = "production"
    Name        = "vpc-taeho-io-production"
  }

  vpc_tags = {
    Name = "vpc-taeho-io-production"
  }

  private_subnet_tags = {
    Subnet = "private"
  }

  public_subnet_tags = {
    Subnet = "public"
  }

  database_subnet_tags = {
    Subnet = "database"
  }
}
