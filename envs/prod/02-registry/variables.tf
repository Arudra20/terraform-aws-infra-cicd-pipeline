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

variable "repositories" {
  description = "ECR repositories."
  type = map(object({
    keep_last_images     = number
    image_tag_mutability = string
    scan_on_push         = bool
  }))
}
