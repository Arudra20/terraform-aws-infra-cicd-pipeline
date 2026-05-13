variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "aws_region" {
  description = "AWS region."
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "oidc_provider_arn" {
  description = "EKS OIDC provider ARN."
  type        = string
}

variable "oidc_provider" {
  description = "EKS OIDC provider URL without https."
  type        = string
}

variable "secrets_manager_secret_arns" {
  description = "Secret ARNs External Secrets can read."
  type        = list(string)
  default     = ["*"]
}

variable "app_service_account_namespace" {
  description = "Application namespace for app IRSA role."
  type        = string
  default     = "apps"
}

variable "app_service_account_name" {
  description = "Application service account name for app IRSA role."
  type        = string
  default     = "app-sa"
}

variable "app_allowed_s3_bucket_arns" {
  description = "S3 bucket ARNs allowed for application IRSA role."
  type        = list(string)
  default     = []
}

variable "common_tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}
