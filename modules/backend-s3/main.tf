resource "aws_s3_bucket" "telecom_state" {
  bucket = var.state_bucket_name

  tags = merge(var.common_tags, {
    Name = var.state_bucket_name
  })
}
