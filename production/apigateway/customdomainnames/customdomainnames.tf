
resource "aws_apigatewayv2_domain_name" "api-taeho-io" {
  domain_name = "api.taeho.io"

  domain_name_configuration {
    certificate_arn = data.terraform_remote_state.acm.outputs.acm-taeho-io-arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  tags = {}
}