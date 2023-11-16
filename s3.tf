resource "aws_s3_bucket" "databucket" {
  bucket = "databucket-${local.account_id}"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "databucket" {
  bucket = aws_s3_bucket.databucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.databucket_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}
