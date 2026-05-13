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

variable "node_groups" {
  description = "EKS node groups."
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    disk_size      = number
    min_size       = number
    desired_size   = number
    max_size       = number
    labels         = map(string)
    taints = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
  }))
}
