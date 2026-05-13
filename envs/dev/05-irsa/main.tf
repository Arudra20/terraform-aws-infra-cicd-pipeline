module "irsa" {
  source = "../../../modules/eks-irsa"

  project_name                  = var.project_name
  environment                   = var.environment
  aws_region                    = var.aws_region
  cluster_name                  = data.terraform_remote_state.cluster.outputs.cluster_name
  oidc_provider_arn             = data.terraform_remote_state.cluster.outputs.oidc_provider_arn
  oidc_provider                 = data.terraform_remote_state.cluster.outputs.oidc_provider
  secrets_manager_secret_arns   = var.secrets_manager_secret_arns
  app_service_account_namespace = var.app_service_account_namespace
  app_service_account_name      = var.app_service_account_name
  app_allowed_s3_bucket_arns    = var.app_allowed_s3_bucket_arns

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
