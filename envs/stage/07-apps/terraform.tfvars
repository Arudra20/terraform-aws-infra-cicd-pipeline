aws_region   = "ap-south-1" # AWS region where resources will be created.
project_name = "sample-eks-platform" # Change this for each new project; used in naming/tags.
environment  = "stage" # Current environment name; keeps names and state paths isolated.
state_bucket = "__TF_STATE_BUCKET__" # Replace after running 00-backend.

apps = {
  user-service = {
    namespace        = "apps" # Kubernetes namespace for this service.
    chart_path       = "../../../helm-charts/generic-service" # Reusable Helm chart path.
    release_name     = "user-service" # Helm release name.
    image_repository = "__AWS_ACCOUNT_ID__.dkr.ecr.ap-south-1.amazonaws.com/sample-eks-platform/dev/user-service" # Replace with ECR URL output.
    image_tag        = "latest" # Replace with Git SHA or build tag from CI/CD.
    replica_count    = 2 # Number of pods.
    service_port     = 80 # Kubernetes service port.
    container_port   = 8080 # Container app port.
    service_account_name     = "app-sa" # Service account used by pod.
    service_account_role_arn = "__APP_SERVICE_ROLE_ARN__" # Replace with 05-irsa app_service_role_arn output or wire via remote state in main.tf.
  }
}
