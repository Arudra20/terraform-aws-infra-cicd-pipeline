resource "helm_release" "cluster_autoscaler" {
  count = var.enable_cluster_autoscaler ? 1 : 0

  name       = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = var.cluster_autoscaler_chart_version

  values = [
    yamlencode({
      autoDiscovery = {
        clusterName = var.cluster_name
      }

      awsRegion = var.aws_region

      rbac = {
        serviceAccount = {
          create = true
          name   = "cluster-autoscaler"
          annotations = {
            "eks.amazonaws.com/role-arn" = var.cluster_autoscaler_role_arn
          }
        }
      }

      extraArgs = {
        "balance-similar-node-groups"  = "true"
        "skip-nodes-with-system-pods"  = "false"
        "skip-nodes-with-local-storage" = "false"
      }

      resources = {
        requests = {
          cpu    = "100m"
          memory = "300Mi"
        }
      }
    })
  ]
}
