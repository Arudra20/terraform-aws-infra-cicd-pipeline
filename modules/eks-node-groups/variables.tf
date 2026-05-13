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

variable "private_subnet_ids" {
  description = "Private subnets where nodes are launched."
  type        = list(string)
}

variable "node_groups" {
  description = "Managed node group configurations."
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

variable "common_tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}
