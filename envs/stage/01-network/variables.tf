variable "aws_region" {
  description = "AWS region where this layer runs."
  type        = string
}

variable "project_name" {
  description = "Reusable project name."
  type        = string
}

variable "environment" {
  description = "Environment name."
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket where Terraform state for this environment is stored."
  type        = string
}

variable "vpc_cidr" {
  description = "Main VPC CIDR."
  type        = string
}

variable "availability_zones" {
  description = "AZs used for subnet creation."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable NAT for private subnet internet egress."
  type        = bool
}

variable "single_nat_gateway" {
  description = "Single NAT for cost or NAT per AZ for HA."
  type        = bool
}

variable "enable_vpc_endpoints" {
  description = "Enable S3/ECR/CloudWatch/STs endpoints."
  type        = bool
}

variable "enable_flow_logs" {
  description = "Enable VPC flow logs."
  type        = bool
}
