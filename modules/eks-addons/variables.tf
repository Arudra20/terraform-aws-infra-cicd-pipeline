variable "aws_region" {
  description = "AWS region."
  type        = string
}

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

variable "vpc_id" {
  description = "VPC ID for AWS Load Balancer Controller."
  type        = string
}

variable "enable_metrics_server" {
  description = "Install Metrics Server."
  type        = bool
  default     = true
}

variable "metrics_server_chart_version" {
  description = "Metrics Server Helm chart version. Change this to upgrade only metrics-server."
  type        = string
  default     = null
}

variable "enable_cluster_autoscaler" {
  description = "Install Cluster Autoscaler."
  type        = bool
  default     = true
}

variable "cluster_autoscaler_chart_version" {
  description = "Cluster Autoscaler Helm chart version. Change this to upgrade only cluster-autoscaler."
  type        = string
  default     = null
}

variable "cluster_autoscaler_role_arn" {
  description = "IRSA role ARN for Cluster Autoscaler."
  type        = string
}

variable "enable_aws_load_balancer_controller" {
  description = "Install AWS Load Balancer Controller."
  type        = bool
  default     = true
}

variable "aws_load_balancer_controller_chart_version" {
  description = "AWS Load Balancer Controller Helm chart version."
  type        = string
  default     = null
}

variable "aws_load_balancer_controller_role_arn" {
  description = "IRSA role ARN for AWS Load Balancer Controller."
  type        = string
}

variable "enable_external_secrets" {
  description = "Install External Secrets Operator."
  type        = bool
  default     = true
}

variable "external_secrets_chart_version" {
  description = "External Secrets Helm chart version."
  type        = string
  default     = null
}

variable "external_secrets_role_arn" {
  description = "IRSA role ARN for External Secrets Operator."
  type        = string
}

variable "enable_monitoring_stack" {
  description = "Install kube-prometheus-stack."
  type        = bool
  default     = false
}

variable "kube_prometheus_stack_chart_version" {
  description = "kube-prometheus-stack Helm chart version."
  type        = string
  default     = null
}

variable "common_tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}
