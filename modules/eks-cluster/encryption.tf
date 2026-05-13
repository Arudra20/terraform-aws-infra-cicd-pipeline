resource "aws_kms_key" "eks" {
  count = var.enable_secrets_encryption ? 1 : 0

  description             = "KMS key for EKS Kubernetes secret encryption"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = merge(local.common_tags, {
    Name = "${var.cluster_name}-secrets-kms"
  })
}

resource "aws_kms_alias" "eks" {
  count = var.enable_secrets_encryption ? 1 : 0

  name          = "alias/${var.cluster_name}-secrets"
  target_key_id = aws_kms_key.eks[0].key_id
}
