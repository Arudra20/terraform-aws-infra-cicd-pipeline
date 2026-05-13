# EKS Terraform Platform Template

This repository is a reusable Terraform template for creating AWS EKS platform projects.

It is designed for multiple projects, multiple environments, and clean upgrade control.

## What this template creates

```text
00-backend      -> S3 Terraform state bucket and optional DynamoDB legacy lock table
01-network      -> VPC, subnets, IGW, NAT, route tables, VPC endpoints, flow logs
02-registry     -> ECR repositories and image lifecycle policies
03-cluster      -> EKS control plane, cluster logs, managed cluster add-ons
04-node-groups  -> EKS worker node groups, labels, taints, scaling tags
05-irsa         -> IAM Roles for Service Accounts for add-ons/app workloads
06-addons       -> Metrics Server, Cluster Autoscaler, AWS Load Balancer Controller, External Secrets, Prometheus/Grafana
07-apps         -> Helm-based application deployment template
```

## Why this structure?

This template uses two levels of separation:

1. **Root stack separation**
   - Each layer under `envs/<env>/<layer>` has a separate Terraform state file.
   - This allows independent upgrade and troubleshooting.
   - Example: You can upgrade Metrics Server without touching VPC or EKS.

2. **Module file separation**
   - Inside each module, resources are split into readable `.tf` files.
   - Example: `modules/network-vpc/subnets.tf`, `nat-gateway.tf`, `route-tables.tf`.
   - Terraform loads all `.tf` files in a folder together, so file separation is for readability, ownership, and easier review.

## PowerShell-first execution

This repo is meant to be executed from a Windows PowerShell terminal.

```powershell
# Go to repo
cd .\eks-terraform-platform-template

# Check prerequisites
.\scripts\Test-Prerequisites.ps1

# Apply one layer
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 01-network -Action apply

# Apply all platform layers in order
.\scripts\Invoke-FullApply.ps1 -Environment dev
```

## First-time usage

1. Create or choose your AWS account.
2. Configure AWS CLI:

```powershell
aws configure
aws sts get-caller-identity
```

3. Update template values:
   - `envs/dev/00-backend/terraform.tfvars`
   - `envs/dev/*/backend.hcl`
   - `envs/dev/*/terraform.tfvars`

4. Create backend first:

```powershell
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 00-backend -Action apply
```

5. Update all `backend.hcl` files with the bucket created in `00-backend`.

6. Apply layers:

```powershell
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 01-network -Action apply
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 02-registry -Action apply
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 03-cluster -Action apply
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 04-node-groups -Action apply
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 05-irsa -Action apply
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 06-addons -Action apply
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 07-apps -Action apply
```

## Important naming placeholders

Replace these values before real usage:

```text
__PROJECT_NAME__       -> your project name, for example telecom-platform
__ENVIRONMENT__        -> dev, stage, prod, qa, uat
__AWS_REGION__         -> ap-south-1, us-east-1, etc.
__TF_STATE_BUCKET__    -> globally unique S3 bucket name
__GITHUB_ORG__         -> GitHub organization/user
__GITHUB_REPO__        -> GitHub repository
__AWS_ACCOUNT_ID__     -> AWS account number
```

## Documentation

Read these files before applying:

```text
docs/01-architecture-flow.md
docs/02-file-purpose-guide.md
docs/03-powershell-execution-guide.md
docs/04-upgrade-strategy.md
docs/05-interview-explanation.md
docs/06-troubleshooting.md
docs/07-official-references.md
```

## Safety notes

- Never commit real secrets.
- Do not use production values directly in `dev`.
- Keep backend state bucket versioning enabled.
- Review `terraform plan` carefully before every apply.
- Use separate AWS accounts for dev/stage/prod where possible.
