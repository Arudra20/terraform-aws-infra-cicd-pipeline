# EKS access entries are created through local.access_entries.
# Add IAM role ARNs into var.eks_admin_role_arns in environment tfvars.
#
# Example:
# eks_admin_role_arns = [
#   "arn:aws:iam::123456789012:role/AdminRole"
# ]
