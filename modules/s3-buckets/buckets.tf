resource "aws_s3_bucket" "this" {
  for_each = var.buckets

  bucket        = "${var.project_name}-${var.environment}-${each.key}"
  force_destroy = each.value.force_destroy

  tags = merge(local.common_tags, {
    Name    = "${var.project_name}-${var.environment}-${each.key}"
    Purpose = each.value.purpose
  })
}
