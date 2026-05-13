variable "aws_region" {
  description = "AWS region where this layer runs."
  type        = string
}

variable "project_name" {
  description = "Reusable project name."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket where Terraform state for this environment is stored."
  type        = string
}

variable "secrets_manager_secret_arns" {
  description = "Secrets Manager ARNs External Secrets can read."
  type        = list(string)
}

variable "app_service_account_namespace" {
  description = "App namespace for app IRSA role."
  type        = string
}

variable "app_service_account_name" {
  description = "App service account name."
  type        = string
}

variable "app_allowed_s3_bucket_arns" {
  description = "S3 buckets app pods can access."
  type        = list(string)
}
