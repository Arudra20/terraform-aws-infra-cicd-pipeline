aws_region   = "ap-south-1"          # Region where the Terraform backend bucket will be created.
project_name = "sample-eks-platform" # Change this for each new project.
environment  = "stage"               # Environment name.

state_bucket_name                 = "sample-eks-platform-stage-tfstate-CHANGE-ME" # Must be globally unique. Replace CHANGE-ME with account/name suffix.
enable_legacy_dynamodb_lock_table = false                                         # New Terraform versions can use S3 native locking with use_lockfile=true.
