
resource "aws_api_gateway_rest_api" "PetStore" {
  name        = "PetStore"
  description = "Your first API with Amazon API Gateway. This is a sample API that integrates via HTTP with our demo Pet Store endpoints"

  policy = jsonencode(
    {
      Statement = [
        {
          Effect    = "Deny"
          Action    = "execute-api:Invoke"
          Principal = "*"
          Resource  = "arn:aws:execute-api:*:*:*"
          Condition = {
            StringNotEquals = {
              "aws:sourceVpc" = data.terraform_remote_state.vpc.outputs.vpc_id
            }
          }
        },
        {
          Effect    = "Allow"
          Action    = "execute-api:Invoke"
          Principal = "*"
          Resource  = "arn:aws:execute-api:*:*:*"
        },
      ]
      Version = "2012-10-17"
    }
  )

  endpoint_configuration {
    types = [
      "PRIVATE",
    ]
  }
}

resource "aws_apigatewayv2_api" "api-taeho-io" {
  name          = "api.taeho.io"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "api-taeho-io-taeho" {
  api_id                 = aws_apigatewayv2_api.api-taeho-io.id
  connection_type        = "INTERNET"
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = data.terraform_remote_state.lambda.outputs.lambda-function-taeho-arn
  passthrough_behavior   = "WHEN_NO_MATCH"
  payload_format_version = "2.0"
  request_templates      = {}
  timeout_milliseconds   = 29000
}

resource "aws_apigatewayv2_route" "api-taeho-io-root" {
  api_id    = aws_apigatewayv2_api.api-taeho-io.id
  route_key = "ANY /"
  target    = "integrations/${aws_apigatewayv2_integration.api-taeho-io-taeho.id}"
}

resource "aws_apigatewayv2_integration" "api-taeho-io-myip" {
  api_id                 = aws_apigatewayv2_api.api-taeho-io.id
  connection_type        = "INTERNET"
  integration_type       = "AWS_PROXY"
  integration_method     = "POST"
  integration_uri        = data.terraform_remote_state.lambda.outputs.lambda-function-myip-arn
  passthrough_behavior   = "WHEN_NO_MATCH"
  payload_format_version = "2.0"
  request_templates      = {}
  timeout_milliseconds   = 29000
}

resource "aws_apigatewayv2_route" "api-taeho-io-myip" {
  api_id    = aws_apigatewayv2_api.api-taeho-io.id
  route_key = "ANY /myip"
  target    = "integrations/${aws_apigatewayv2_integration.api-taeho-io-myip.id}"
}


resource "aws_apigatewayv2_stage" "api-taeho-io-production" {
  api_id      = aws_apigatewayv2_api.api-taeho-io.id
  name        = "production"
  auto_deploy = true
}

resource "aws_apigatewayv2_api_mapping" "api-taeho-io-production" {
  api_id      = aws_apigatewayv2_api.api-taeho-io.id
  domain_name = aws_apigatewayv2_api.api-taeho-io.name
  stage       = aws_apigatewayv2_stage.api-taeho-io-production.name
}
