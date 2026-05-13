resource "aws_s3_bucket_lifecycle_configuration" "this" {
  for_each = {
    for name, cfg in var.buckets : name => cfg
    if cfg.retention_days > 0
  }

  bucket = aws_s3_bucket.this[each.key].id

  rule {
    id     = "expire-old-objects"
    status = "Enabled"

    filter {}

    expiration {
      days = each.value.retention_days
    }
  }
}
