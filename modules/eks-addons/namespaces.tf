resource "kubernetes_namespace" "monitoring" {
  count = var.enable_monitoring_stack ? 1 : 0

  metadata {
    name = local.monitoring_namespace
  }
}

resource "kubernetes_namespace" "external_secrets" {
  count = var.enable_external_secrets ? 1 : 0

  metadata {
    name = local.external_secrets_namespace
  }
}
