aws_region   = "ap-south-1"          # AWS region where resources will be created.
project_name = "sample-eks-platform" # Change this for each new project; used in naming/tags.
environment  = "prod"                # Current environment name; keeps names and state paths isolated.
state_bucket = "__TF_STATE_BUCKET__" # Replace after running 00-backend.

secrets_manager_secret_arns = [
  "*" # Template default. Replace with exact secret ARNs for production least privilege.
]

app_service_account_namespace = "apps"   # Namespace where application service account will be created.
app_service_account_name      = "app-sa" # Service account name used by application Helm chart.

app_allowed_s3_bucket_arns = [
  # "arn:aws:s3:::sample-eks-platform-dev-app-logs", # Add buckets only if app pods need S3 access.
]
