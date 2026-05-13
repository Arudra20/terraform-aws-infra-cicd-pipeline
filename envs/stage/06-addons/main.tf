module "eks_addons" {
  source = "../../../modules/eks-addons"

  aws_region   = var.aws_region
  project_name = var.project_name
  environment  = var.environment
  cluster_name = data.terraform_remote_state.cluster.outputs.cluster_name
  vpc_id       = data.terraform_remote_state.network.outputs.vpc_id

  enable_metrics_server        = var.enable_metrics_server
  metrics_server_chart_version = var.metrics_server_chart_version

  enable_cluster_autoscaler        = var.enable_cluster_autoscaler
  cluster_autoscaler_chart_version = var.cluster_autoscaler_chart_version
  cluster_autoscaler_role_arn      = data.terraform_remote_state.irsa.outputs.cluster_autoscaler_role_arn

  enable_aws_load_balancer_controller        = var.enable_aws_load_balancer_controller
  aws_load_balancer_controller_chart_version = var.aws_load_balancer_controller_chart_version
  aws_load_balancer_controller_role_arn      = data.terraform_remote_state.irsa.outputs.aws_load_balancer_controller_role_arn

  enable_external_secrets        = var.enable_external_secrets
  external_secrets_chart_version = var.external_secrets_chart_version
  external_secrets_role_arn      = data.terraform_remote_state.irsa.outputs.external_secrets_role_arn

  enable_monitoring_stack             = var.enable_monitoring_stack
  kube_prometheus_stack_chart_version = var.kube_prometheus_stack_chart_version
}
