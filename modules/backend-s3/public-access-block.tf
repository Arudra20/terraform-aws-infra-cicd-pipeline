resource "aws_s3_bucket_public_access_block" "telecom_state" {
  bucket = aws_s3_bucket.telecom_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
