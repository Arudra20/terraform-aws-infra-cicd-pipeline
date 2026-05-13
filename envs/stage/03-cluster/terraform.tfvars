aws_region   = "ap-south-1" # AWS region where resources will be created.
project_name = "sample-eks-platform" # Change this for each new project; used in naming/tags.
environment  = "stage" # Current environment name; keeps names and state paths isolated.
state_bucket = "__TF_STATE_BUCKET__" # Replace after running 00-backend.

cluster_name    = "sample-eks-platform-stage-eks" # EKS cluster name. Keep unique per environment.
cluster_version = "1.30" # Upgrade carefully one minor version at a time.

cluster_endpoint_public_access  = true # Allows kubectl from your laptop/CloudShell. Restrict CIDR in production.
cluster_endpoint_private_access = true # Allows access from inside VPC.

cluster_endpoint_public_access_cidrs = [
  "0.0.0.0/0", # Template default. Replace with office/VPN IP CIDR for production.
]

enabled_cluster_log_types = [
  "api",           # API server requests.
  "audit",         # Security audit logs.
  "authenticator", # IAM authentication logs.
]

enable_secrets_encryption = true # Creates KMS key for Kubernetes secret encryption.

eks_admin_role_arns = [
  # "arn:aws:iam::__AWS_ACCOUNT_ID__:role/AdminRole", # Add admin role ARNs that need EKS access.
]
