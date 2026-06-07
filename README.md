<!-- Badges -->
<p align="left">
  <img src="https://img.shields.io/badge/Terraform-1.x-7B42BC?style=flat&logo=terraform&logoColor=white"/>
  <img src="https://img.shields.io/badge/AWS-EKS-FF9900?style=flat&logo=amazonaws&logoColor=white"/>
  <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat&logo=githubactions&logoColor=white"/>
  <img src="https://img.shields.io/badge/Helm-3.x-0F1689?style=flat&logo=helm&logoColor=white"/>
  <img src="https://img.shields.io/badge/License-MIT-green?style=flat"/>
</p>

# aws-eks-terraform-platform

**Reusable Terraform platform template for Amazon EKS** — multi-environment, multi-layer state management, CI/CD-driven infrastructure delivery via GitHub Actions, and a complete add-on stack (ALB Controller, Cluster Autoscaler, External Secrets, Prometheus/Grafana).

This template is designed to be forked and customised for any AWS EKS project. Replace the placeholder values, run the scripts, and you have a production-ready Kubernetes platform.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    GitHub Actions (CI/CD)                       │
│           Terraform plan on PR → Terraform apply on merge       │
│           OIDC authentication → no static AWS keys             │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
         ┌───────────────────────────────┐
         │         S3 + DynamoDB         │
         │   Layered Terraform State     │
         │   (one state file per layer)  │
         └───────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                       AWS VPC                                   │
│                                                                 │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────────┐  │
│  │ Public       │    │ Private      │    │ VPC Endpoints    │  │
│  │ Subnets      │    │ Subnets      │    │ ECR, S3,         │  │
│  │ (ALB)        │    │ (EKS nodes)  │    │ CloudWatch       │  │
│  └──────────────┘    └──────┬───────┘    └──────────────────┘  │
│                             │                                   │
│                    ┌────────▼───────┐                           │
│                    │ EKS Cluster    │                           │
│                    │                │                           │
│                    │ Add-ons:       │                           │
│                    │ • ALB Ctrl     │                           │
│                    │ • Autoscaler   │                           │
│                    │ • Ext. Secrets │                           │
│                    │ • Prometheus   │                           │
│                    └────────────────┘                           │
└─────────────────────────────────────────────────────────────────┘
```

---

## Platform layers

```
00-backend      → S3 Terraform state bucket + DynamoDB lock table
01-network      → VPC, subnets, IGW, NAT, route tables, VPC endpoints, flow logs
02-registry     → ECR repositories + image lifecycle policies
03-cluster      → EKS control plane, cluster logs, managed add-ons
04-node-groups  → Worker node groups (labels, taints, scaling tags)
05-irsa         → IAM Roles for Service Accounts
06-addons       → Metrics Server, Cluster Autoscaler, ALB Controller, External Secrets, Prometheus/Grafana
07-apps         → Helm-based application deployment template
```

Each layer has its own Terraform state file, so upgrades are scoped and isolated.

---

## CI/CD pipeline for infrastructure

The `.github/workflows/` directory contains GitHub Actions workflows for:

- **PR opened** → `terraform plan` runs automatically, plan output posted as a PR comment
- **PR merged to main** → `terraform apply` runs automatically for the changed layer
- **Manual dispatch** → apply any specific layer in any environment

Authentication uses GitHub OIDC — no AWS access keys stored in GitHub secrets.

---

## Multi-environment design

```
envs/
├── dev/
│   ├── 00-backend/
│   │   ├── backend.hcl
│   │   └── terraform.tfvars
│   ├── 01-network/
│   ├── 03-cluster/
│   └── ...
├── stage/
│   └── ...
└── prod/
    └── ...
```

Each environment is fully independent. Promoting from dev to stage means copying the `terraform.tfvars`, reviewing the plan, and applying — no shared state, no risk of cross-environment impact.

---

## Quick start

### Prerequisites

```bash
terraform --version   # >= 1.5
aws --version         # >= 2.x
kubectl version       # >= 1.28
helm version          # >= 3.12
pwsh --version        # >= 7.x
```

### 1. Configure AWS credentials

```bash
aws configure
aws sts get-caller-identity
```

### 2. Update placeholder values

Search and replace across the repo:

| Placeholder | Replace with |
|---|---|
| `__PROJECT_NAME__` | Your project name (e.g. `my-platform`) |
| `__ENVIRONMENT__` | `dev`, `stage`, or `prod` |
| `__AWS_REGION__` | e.g. `ap-south-1` |
| `__TF_STATE_BUCKET__` | Globally unique S3 bucket name |
| `__GITHUB_ORG__` | Your GitHub username or org |
| `__GITHUB_REPO__` | This repository name |
| `__AWS_ACCOUNT_ID__` | Your 12-digit AWS account ID |

Files to update:
```
envs/dev/00-backend/terraform.tfvars
envs/dev/*/backend.hcl
envs/dev/*/terraform.tfvars
```

### 3. Bootstrap the backend (once)

```powershell
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 00-backend -Action apply
```

Then update all `backend.hcl` files with the S3 bucket name from the output.

### 4. Apply all layers

```powershell
# Apply all in order
.\scripts\Invoke-FullApply.ps1 -Environment dev

# Or apply one at a time
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 01-network -Action apply
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 03-cluster -Action apply
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 06-addons -Action apply
```

### 5. Connect kubectl

```bash
aws eks update-kubeconfig --region ap-south-1 --name __PROJECT_NAME__-dev
kubectl get nodes
kubectl get pods -A
```

---

## Add-ons included

| Add-on | Purpose |
|---|---|
| AWS Load Balancer Controller | Creates ALBs from Kubernetes Ingress resources |
| Cluster Autoscaler | Scales node groups up/down based on pod demand |
| Metrics Server | Enables `kubectl top` and HPA |
| External Secrets Operator | Syncs AWS Secrets Manager secrets into Kubernetes |
| kube-prometheus-stack | Prometheus + Grafana + alerting rules |

All add-ons are deployed via Helm with values files in `helm-charts/`. IRSA is configured so each add-on has the minimum IAM permissions it needs — no node-level IAM roles with broad permissions.

---

## Key design decisions

**Why one Terraform state file per layer?**
A single state for the whole platform means every `plan` reads 200+ resources. Separate states give fast, focused operations. More importantly, a `destroy` on `06-addons` cannot accidentally delete your VPC or cluster.

**Why VPC endpoints instead of NAT for ECR and S3?**
VPC endpoints route ECR and S3 traffic privately within the AWS network — no NAT gateway costs for image pulls. This also eliminates public internet exposure for the most common cluster traffic patterns.

**Why IRSA instead of node IAM roles?**
IRSA grants IAM permissions per Kubernetes service account. The ALB Controller gets exactly the permissions it needs — nothing more. If the ALB Controller pod were compromised, the blast radius is limited to ALB operations, not the whole node's IAM role.

---

## Documentation

```
docs/01-architecture-flow.md
docs/02-file-purpose-guide.md
docs/03-powershell-execution-guide.md
docs/04-upgrade-strategy.md
docs/05-interview-explanation.md
docs/06-troubleshooting.md
docs/07-official-references.md
```

---

## Safety guidelines

- Never commit real values — use `terraform.tfvars.example` files as templates
- Keep S3 state bucket versioning enabled
- Review `terraform plan` carefully before every apply
- Use separate AWS accounts for dev / stage / prod
- Restrict the GitHub OIDC IAM role to specific branches (`ref:refs/heads/main`)

---

## Interview explanation

> I built a reusable Terraform platform template for EKS with layered state management — each infrastructure concern (network, cluster, add-ons) has its own Terraform state file, so you can upgrade Prometheus without touching the VPC. The CI/CD pipeline uses GitHub Actions with OIDC for keyless AWS authentication — no long-lived credentials anywhere. Infrastructure delivery is fully automated: Terraform plan runs on every PR, apply runs on merge. The platform includes the ALB Controller, Cluster Autoscaler, External Secrets Operator with IRSA, and kube-prometheus-stack, all deployed via Helm.

---

## Topics

`aws` `eks` `terraform` `iac` `kubernetes` `github-actions` `helm` `ci-cd` `devops` `platform-engineering` `oidc` `cluster-autoscaler` `irsa` `alb-controller`
