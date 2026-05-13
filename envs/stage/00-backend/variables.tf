variable "aws_region" {
  description = "AWS region where the backend bucket will be created."
  type        = string
}

variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform state."
  type        = string
}

variable "enable_legacy_dynamodb_lock_table" {
  description = "Enable legacy DynamoDB locking table. Prefer S3 use_lockfile for new projects."
  type        = bool
  default     = false
}
