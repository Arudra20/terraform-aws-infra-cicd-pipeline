module "backend" {
  source = "../../../modules/backend-s3"

  aws_region                        = var.aws_region
  state_bucket_name                 = var.state_bucket_name
  enable_legacy_dynamodb_lock_table = var.enable_legacy_dynamodb_lock_table

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
