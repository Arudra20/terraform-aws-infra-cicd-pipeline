resource "aws_iam_role" "app_service" {
  name = "${var.project_name}-${var.environment}-app-service-irsa"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = var.oidc_provider_arn
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${var.oidc_provider}:sub" = "system:serviceaccount:${var.app_service_account_namespace}:${var.app_service_account_name}"
          "${var.oidc_provider}:aud" = "sts.amazonaws.com"
        }
      }
    }]
  })

  tags = local.common_tags
}

resource "aws_iam_policy" "app_service_s3" {
  count = length(var.app_allowed_s3_bucket_arns) > 0 ? 1 : 0

  name = "${var.project_name}-${var.environment}-app-service-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
      Resource = concat(var.app_allowed_s3_bucket_arns, [for arn in var.app_allowed_s3_bucket_arns : "${arn}/*"])
    }]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "app_service_s3" {
  count = length(var.app_allowed_s3_bucket_arns) > 0 ? 1 : 0

  role       = aws_iam_role.app_service.name
  policy_arn = aws_iam_policy.app_service_s3[0].arn
}
