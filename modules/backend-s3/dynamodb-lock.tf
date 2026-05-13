resource "aws_dynamodb_table" "terraform_locks" {
  count = var.enable_legacy_dynamodb_lock_table ? 1 : 0

  name         = coalesce(var.dynamodb_lock_table_name, "${var.state_bucket_name}-locks")
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(var.common_tags, {
    Name = coalesce(var.dynamodb_lock_table_name, "${var.state_bucket_name}-locks")
  })
}
