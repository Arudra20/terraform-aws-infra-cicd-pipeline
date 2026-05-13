bucket       = "telecom-dev-123456" # Replace with the S3 bucket created by 00-backend.
key          = "dev/05-irsa/terraform.tfstate" # Separate state path so this layer upgrades independently.
region       = "__AWS_REGION__" # AWS region where the backend bucket exists.
encrypt      = true # Encrypt state at rest.
use_lockfile = true # Native S3 state locking; avoids concurrent apply issues.
