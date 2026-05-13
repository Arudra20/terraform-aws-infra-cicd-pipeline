output "aws_load_balancer_controller_role_arn" {
  value = module.irsa.aws_load_balancer_controller_role_arn
}

output "cluster_autoscaler_role_arn" {
  value = module.irsa.cluster_autoscaler_role_arn
}

output "external_secrets_role_arn" {
  value = module.irsa.external_secrets_role_arn
}

output "ebs_csi_role_arn" {
  value = module.irsa.ebs_csi_role_arn
}

output "app_service_role_arn" {
  value = module.irsa.app_service_role_arn
}
