resource "aws_route53_zone" "taeho-io-public" {
  name    = "taeho.io"
  comment = "taeho.io public hosted zone"

  tags = {}
}
