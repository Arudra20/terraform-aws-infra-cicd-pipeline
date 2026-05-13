variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "buckets" {
  description = "Application S3 buckets to create."
  type = map(object({
    purpose            = string
    versioning_enabled = bool
    force_destroy      = bool
    retention_days     = number
  }))
}

variable "common_tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}
