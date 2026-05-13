aws_region   = "ap-south-1"   # Region where the Terraform backend bucket will be created.
project_name = "eks-platform" # Change this for each new project.
environment  = "dev"          # Environment name.

state_bucket_name                 = "telecom-dev-123456" # Must be globally unique. Replace CHANGE-ME with account/name suffix.
enable_legacy_dynamodb_lock_table = false              # New Terraform versions can use S3 native locking with use_lockfile=true.
