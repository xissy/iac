
output "PetStore-execution-arn" {
  value = aws_api_gateway_rest_api.PetStore.execution_arn
}

output "api-taeho-io-production-invoke-url" {
  value = aws_apigatewayv2_stage.api-taeho-io-production.invoke_url
}
