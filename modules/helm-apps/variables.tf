variable "cluster_name" {
  description = "EKS cluster name."
  type        = string
}

variable "apps" {
  description = "Map of applications to deploy by Helm."
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
