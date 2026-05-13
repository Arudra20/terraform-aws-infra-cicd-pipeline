module "eks_cluster" {
  source = "../../../modules/eks-cluster"

  project_name                         = var.project_name
  environment                          = var.environment
  cluster_name                         = var.cluster_name
  cluster_version                      = var.cluster_version
  vpc_id                               = data.terraform_remote_state.network.outputs.vpc_id
  private_subnet_ids                   = data.terraform_remote_state.network.outputs.private_subnet_ids
  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs
  enabled_cluster_log_types            = var.enabled_cluster_log_types
  enable_secrets_encryption            = var.enable_secrets_encryption
  eks_admin_role_arns                  = var.eks_admin_role_arns

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
