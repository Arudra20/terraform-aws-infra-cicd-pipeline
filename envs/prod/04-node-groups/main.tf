module "node_groups" {
  source = "../../../modules/eks-node-groups"

  project_name       = var.project_name
  environment        = var.environment
  cluster_name       = data.terraform_remote_state.cluster.outputs.cluster_name
  private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  node_groups        = var.node_groups

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
