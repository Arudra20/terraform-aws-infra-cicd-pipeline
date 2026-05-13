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

variable "apps" {
  description = "Applications deployed by Helm."
  type = map(object({
    namespace                = string
    chart_path               = string
    release_name             = string
    image_repository         = string
    image_tag                = string
    replica_count            = number
    service_port             = number
    container_port           = number
    service_account_name     = string
    service_account_role_arn = string
  }))
}
