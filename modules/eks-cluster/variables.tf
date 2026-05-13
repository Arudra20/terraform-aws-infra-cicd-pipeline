variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes/EKS version."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where EKS control plane connects."
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs used by EKS."
  type        = list(string)
}

variable "cluster_endpoint_public_access" {
  description = "Whether EKS API endpoint is public."
  type        = bool
  default     = true
}

variable "cluster_endpoint_private_access" {
  description = "Whether EKS API endpoint is private."
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "CIDR ranges allowed to access public EKS endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enabled_cluster_log_types" {
  description = "EKS control plane logs to enable."
  type        = list(string)
  default     = ["api", "audit", "authenticator"]
}

variable "enable_secrets_encryption" {
  description = "Whether to create KMS key for EKS secret encryption."
  type        = bool
  default     = true
}

variable "eks_admin_role_arns" {
  description = "IAM role ARNs to grant EKS admin access entries."
  type        = list(string)
  default     = []
}

variable "common_tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}
