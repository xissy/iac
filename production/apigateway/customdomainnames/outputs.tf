
output "api-taeho-io-regional-domain-name" {
  description = "api.taeho.io regional_domain_name"
  value       = aws_apigatewayv2_domain_name.api-taeho-io.domain_name_configuration[0].target_domain_name
}

output "api-taeho-io-regional-zone-id" {
  description = "api.taeho.io regional_zone_id"
  value       = aws_apigatewayv2_domain_name.api-taeho-io.domain_name_configuration[0].hosted_zone_id
}
