output "aws_load_balancer_controller_role_arn" {
  description = "IRSA role ARN for AWS Load Balancer Controller."
  value       = aws_iam_role.aws_load_balancer_controller.arn
}

output "cluster_autoscaler_role_arn" {
  description = "IRSA role ARN for Cluster Autoscaler."
  value       = aws_iam_role.cluster_autoscaler.arn
}

output "external_secrets_role_arn" {
  description = "IRSA role ARN for External Secrets Operator."
  value       = aws_iam_role.external_secrets.arn
}

output "ebs_csi_role_arn" {
  description = "IRSA role ARN for EBS CSI Driver."
  value       = aws_iam_role.ebs_csi.arn
}

output "app_service_role_arn" {
  description = "IRSA role ARN for application service account."
  value       = aws_iam_role.app_service.arn
}
