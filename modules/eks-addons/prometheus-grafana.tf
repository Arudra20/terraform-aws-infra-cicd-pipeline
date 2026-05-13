resource "helm_release" "kube_prometheus_stack" {
  count = var.enable_monitoring_stack ? 1 : 0

  name       = "kube-prometheus-stack"
  namespace  = local.monitoring_namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.kube_prometheus_stack_chart_version

  values = [
    yamlencode({
      grafana = {
        enabled = true
        adminPassword = "change-me-after-install"
      }

      prometheus = {
        prometheusSpec = {
          retention = "15d"
        }
      }
    })
  ]

  depends_on = [kubernetes_namespace.monitoring]
}
