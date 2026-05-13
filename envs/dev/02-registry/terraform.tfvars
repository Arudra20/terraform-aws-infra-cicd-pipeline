aws_region   = "ap-south-1"          # AWS region where resources will be created.
project_name = "eks-platform"        # Change this for each new project; used in naming/tags.
environment  = "dev"                 # Current environment name; keeps names and state paths isolated.
state_bucket = "__TF_STATE_BUCKET__" # Replace after running 00-backend.

repositories = {
  user-service = {
    keep_last_images     = 20          # Deletes older images after latest 20 to control storage cost.
    image_tag_mutability = "IMMUTABLE" # Prevents overwriting existing tags; safer for rollback.
    scan_on_push         = true        # Enables ECR image vulnerability scan on push.
  }

  order-service = {
    keep_last_images     = 20          # Adjust per service release frequency.
    image_tag_mutability = "IMMUTABLE" # Recommended for CI/CD traceability.
    scan_on_push         = true        # Useful for DevSecOps image checks.
  }

  payment-service = {
    keep_last_images     = 30          # Payment service keeps more images for rollback/audit.
    image_tag_mutability = "IMMUTABLE" # Prevents accidental tag reuse.
    scan_on_push         = true        # Scans pushed images.
  }
}
