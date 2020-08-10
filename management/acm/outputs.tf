
output "acm-taeho-io-arn" {
  description = "ARN of taeho.io ACM"
  value       = aws_acm_certificate.taeho-io.arn
}
