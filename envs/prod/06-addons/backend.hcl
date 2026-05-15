bucket       = "eks-platform-prod" # Replace with the S3 bucket created by 00-backend.
key          = "prod/06-addons/terraform.tfstate" # Separate state path so this layer upgrades independently.
region       = "ap-south-1" # AWS region where the backend bucket exists.
encrypt      = true # Encrypt state at rest.
use_lockfile = true # Native S3 state locking; avoids concurrent apply issues.
