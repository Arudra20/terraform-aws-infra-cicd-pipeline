output "node_group_names" {
  description = "Created EKS node group names."
  value       = { for name, ng in aws_eks_node_group.this : name => ng.node_group_name }
}

output "node_role_arn" {
  description = "IAM role ARN used by worker nodes."
  value       = aws_iam_role.node_group.arn
}
