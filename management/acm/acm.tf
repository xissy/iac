
resource "aws_acm_certificate" "taeho-io" {
  domain_name = "taeho.io"
  subject_alternative_names = [
    "*.taeho.io",
  ]
  validation_method = "EMAIL"
}

resource "aws_acm_certificate_validation" "taeho-io" {
  certificate_arn = aws_acm_certificate.taeho-io.arn
}
