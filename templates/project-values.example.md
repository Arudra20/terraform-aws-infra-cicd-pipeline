# Project Values Template

Use this file to decide values before editing `terraform.tfvars`.

## Basic project values

```text
project_name = "telecom-eks-platform"
aws_region   = "ap-south-1"
environments = ["dev", "stage", "prod"]
```

## Backend bucket naming

S3 bucket names are globally unique. Use a format like:

```text
<project>-<env>-tfstate-<account-id>
```

Example:

```text
telecom-eks-platform-dev-tfstate-123456789012
```

## VPC CIDR planning

Example:

```text
dev   -> 10.20.0.0/16
stage -> 10.40.0.0/16
prod  -> 10.60.0.0/16
```

Avoid overlapping CIDRs if you plan VPC peering, Transit Gateway, VPN, or Direct Connect.

## Cluster naming

Example:

```text
telecom-eks-platform-dev-eks
telecom-eks-platform-stage-eks
telecom-eks-platform-prod-eks
```

## Node group choices

Dev:

```text
t3.medium
1-4 nodes
single NAT
```

Prod:

```text
m6i.large or m7i.large
3-10 nodes
NAT per AZ
```
