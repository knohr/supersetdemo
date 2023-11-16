resource "aws_kms_key" "a" {
  description             = "KMS key 1"
  deletion_window_in_days = 10
}

resource "aws_kms_key" "databucket_key" {
  description             = "databucket_key"
  deletion_window_in_days = 10
}
