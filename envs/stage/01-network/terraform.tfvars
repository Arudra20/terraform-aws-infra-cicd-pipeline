aws_region   = "ap-south-1" # AWS region where resources will be created.
project_name = "sample-eks-platform" # Change this for each new project; used in naming/tags.
environment  = "stage" # Current environment name; keeps names and state paths isolated.
state_bucket = "__TF_STATE_BUCKET__" # Replace after running 00-backend.

vpc_cidr = "10.40.0.0/16" # Main VPC CIDR range for this environment.

availability_zones = [
  "ap-south-1a",
  "ap-south-1b",
] # Use at least 2 AZs for HA.

public_subnet_cidrs = [
  "10.40.1.0/24",
  "10.40.2.0/24",
] # Public subnets host ALB/NAT Gateway.

private_subnet_cidrs = [
  "10.40.11.0/24",
  "10.40.12.0/24",
] # Private subnets host EKS worker nodes.

enable_nat_gateway = true # Required when private nodes need outbound internet without public IPs.
single_nat_gateway = true # dev/stage: true for cost; prod: false for HA.

enable_vpc_endpoints = true # Creates private endpoints for S3/ECR/logs/STS; reduces NAT dependency.
enable_flow_logs     = false # Turn true for auditing/network troubleshooting; adds CloudWatch cost.
