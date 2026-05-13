output "installed_addons" {
  description = "Helm add-ons requested by this module."
  value = {
    metrics_server               = var.enable_metrics_server
    cluster_autoscaler           = var.enable_cluster_autoscaler
    aws_load_balancer_controller = var.enable_aws_load_balancer_controller
    external_secrets             = var.enable_external_secrets
    monitoring_stack             = var.enable_monitoring_stack
  }
}
