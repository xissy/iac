
resource "aws_s3_bucket" "taeho-io-iac-terraform-state" {
  bucket = "taeho-io-iac-terraform-state"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}
