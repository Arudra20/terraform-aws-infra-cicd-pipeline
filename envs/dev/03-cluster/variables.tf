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

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "cluster_version" {
  description = "EKS/Kubernetes version."
  type        = string
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to EKS API."
  type        = bool
}

variable "cluster_endpoint_private_access" {
  description = "Enable private access to EKS API."
  type        = bool
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "Allowed CIDRs for public EKS API."
  type        = list(string)
}

variable "enabled_cluster_log_types" {
  description = "EKS control plane log types."
  type        = list(string)
}

variable "enable_secrets_encryption" {
  description = "Enable KMS encryption for Kubernetes secrets."
  type        = bool
}

variable "eks_admin_role_arns" {
  description = "IAM role ARNs to grant EKS admin access."
  type        = list(string)
  default     = []
}
