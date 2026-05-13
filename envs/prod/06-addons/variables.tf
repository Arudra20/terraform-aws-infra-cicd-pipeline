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

variable "enable_metrics_server" {
  description = "Enable Metrics Server."
  type        = bool
}

variable "metrics_server_chart_version" {
  description = "Metrics Server chart version."
  type        = string
  default     = null
}

variable "enable_cluster_autoscaler" {
  description = "Enable Cluster Autoscaler."
  type        = bool
}

variable "cluster_autoscaler_chart_version" {
  description = "Cluster Autoscaler chart version."
  type        = string
  default     = null
}

variable "enable_aws_load_balancer_controller" {
  description = "Enable AWS Load Balancer Controller."
  type        = bool
}

variable "aws_load_balancer_controller_chart_version" {
  description = "AWS Load Balancer Controller chart version."
  type        = string
  default     = null
}

variable "enable_external_secrets" {
  description = "Enable External Secrets."
  type        = bool
}

variable "external_secrets_chart_version" {
  description = "External Secrets chart version."
  type        = string
  default     = null
}

variable "enable_monitoring_stack" {
  description = "Enable kube-prometheus-stack."
  type        = bool
}

variable "kube_prometheus_stack_chart_version" {
  description = "kube-prometheus-stack chart version."
  type        = string
  default     = null
}
