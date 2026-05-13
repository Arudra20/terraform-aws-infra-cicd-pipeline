module "helm_apps" {
  source = "../../../modules/helm-apps"

  cluster_name = data.terraform_remote_state.cluster.outputs.cluster_name
  apps         = var.apps
}
