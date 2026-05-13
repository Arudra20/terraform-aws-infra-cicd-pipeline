variable "project_name" {
  description = "Reusable project name. Used in resource names and tags."
  type        = string
}

variable "environment" {
  description = "Environment name like dev, stage, prod, qa, uat."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "availability_zones" {
  description = "AZs used for public/private subnet distribution."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs. Usually one per AZ."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs. Usually one per AZ."
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether private subnets need internet egress through NAT Gateway."
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "true = cheaper single NAT; false = NAT per AZ for high availability."
  type        = bool
  default     = true
}

variable "enable_vpc_endpoints" {
  description = "Creates VPC endpoints for private access to AWS services."
  type        = bool
  default     = true
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs for network troubleshooting/auditing."
  type        = bool
  default     = false
}

variable "common_tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}
