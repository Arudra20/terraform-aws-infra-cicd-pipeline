resource "helm_release" "apps" {
  for_each = var.apps

  name      = each.value.release_name
  namespace = each.value.namespace
  chart     = each.value.chart_path

  values = [
    yamlencode({
      replicaCount = each.value.replica_count

      image = {
        repository = each.value.image_repository
        tag        = each.value.image_tag
      }

      service = {
        port = each.value.service_port
      }

      container = {
        port = each.value.container_port
      }

      serviceAccount = {
        create = true
        name   = each.value.service_account_name
        annotations = {
          "eks.amazonaws.com/role-arn" = each.value.service_account_role_arn
        }
      }
    })
  ]

  depends_on = [kubernetes_namespace.apps]
}
