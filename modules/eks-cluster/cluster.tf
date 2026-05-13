module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  cluster_endpoint_public_access       = var.cluster_endpoint_public_access
  cluster_endpoint_private_access      = var.cluster_endpoint_private_access
  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  enable_irsa = true

  cluster_enabled_log_types = var.enabled_cluster_log_types

  cluster_encryption_config = var.enable_secrets_encryption ? {
    provider_key_arn = aws_kms_key.eks[0].arn
    resources        = ["secrets"]
  } : {}

  cluster_addons = local.eks_managed_addons

  access_entries = local.access_entries

  enable_cluster_creator_admin_permissions = true

  tags = local.common_tags
}
