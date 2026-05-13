resource "aws_s3_bucket_versioning" "telecom_state" {
  bucket = aws_s3_bucket.telecom_state.id

  versioning_configuration {
    status = "Enabled"
  }
}
