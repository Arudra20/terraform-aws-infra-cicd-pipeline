variable "project_name" {
  description = "Project name used in ECR repository naming."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "repositories" {
  description = "Map of ECR repositories to create."
  type = map(object({
    keep_last_images     = number
    image_tag_mutability = string
    scan_on_push         = bool
  }))
}

variable "common_tags" {
  description = "Common tags applied to repositories."
  type        = map(string)
  default     = {}
}
