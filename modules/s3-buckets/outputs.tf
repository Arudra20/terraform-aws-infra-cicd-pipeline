output "bucket_names" {
  description = "Created bucket names."
  value       = { for name, bucket in aws_s3_bucket.this : name => bucket.bucket }
}

output "bucket_arns" {
  description = "Created bucket ARNs."
  value       = { for name, bucket in aws_s3_bucket.this : name => bucket.arn }
}
