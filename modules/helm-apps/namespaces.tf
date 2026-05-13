resource "kubernetes_namespace" "apps" {
  for_each = toset(distinct([for app in values(var.apps) : app.namespace]))

  metadata {
    name = each.value
  }
}
