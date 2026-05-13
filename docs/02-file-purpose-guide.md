# 02 - Terraform File Purpose Guide

This file explains why each Terraform file exists and what functionality it controls.

## Important Terraform rule

Terraform loads all `.tf` files in the same directory as one module.

So these files:

```text
vpc.tf
subnets.tf
route-tables.tf
outputs.tf
```

are not separate execution units. They are separated for readability and maintainability.

For independent apply/upgrade, this template uses separate root stacks:

```text
01-network
03-cluster
04-node-groups
06-addons
```

## Common files

| File | Purpose | Why it matters |
|---|---|---|
| `versions.tf` | Locks Terraform and provider/module versions | Prevents unexpected behavior after provider upgrades |
| `providers.tf` | Configures AWS, Kubernetes, or Helm provider | Tells Terraform where/how to create resources |
| `variables.tf` | Declares module inputs | Makes modules reusable across projects |
| `terraform.tfvars` | Gives real values for one environment | Keeps dev/stage/prod values separate |
| `locals.tf` | Common naming, tags, computed values | Avoids repeated logic |
| `data.tf` | Reads existing AWS resources or remote states | Connects layers safely |
| `main.tf` | Main module call in root stacks | Keeps root stack readable |
| `outputs.tf` | Exposes values for other layers | Enables stack-to-stack dependency |
| `backend.hcl` | Remote backend config | Keeps state isolated per layer |

## Network module files

Path:

```text
modules/network-vpc
```

| File | Functionality |
|---|---|
| `vpc.tf` | Creates VPC and DNS support |
| `subnets.tf` | Creates public/private subnets and EKS load balancer tags |
| `internet-gateway.tf` | Creates IGW for public internet access |
| `nat-gateway.tf` | Creates Elastic IP and NAT Gateway for private subnets |
| `route-tables.tf` | Creates public/private route tables and associations |
| `vpc-endpoints.tf` | Creates private connectivity to AWS services like S3/ECR/CloudWatch |
| `flow-logs.tf` | Enables network flow logs for auditing/troubleshooting |
| `outputs.tf` | Exposes VPC/subnet/route IDs |

## EKS cluster module files

Path:

```text
modules/eks-cluster
```

| File | Functionality |
|---|---|
| `cluster.tf` | Creates EKS control plane through terraform-aws-eks module |
| `cluster-addons.tf` | Defines EKS managed add-ons: CoreDNS, kube-proxy, VPC CNI, EBS CSI |
| `cluster-logging.tf` | Controls API/audit/authenticator logs |
| `encryption.tf` | Defines KMS key for Kubernetes secret encryption |
| `access-entries.tf` | Controls cluster access entries |
| `outputs.tf` | Exposes cluster name, endpoint, CA, OIDC provider details |

## Node group module files

Path:

```text
modules/eks-node-groups
```

| File | Functionality |
|---|---|
| `iam.tf` | Creates node IAM role |
| `node-groups.tf` | Creates managed worker node groups |
| `launch-template.tf` | Optional launch template settings |
| `autoscaling-tags.tf` | Adds autoscaler discovery tags |
| `outputs.tf` | Exposes node group names and role ARN |

## IRSA module files

Path:

```text
modules/eks-irsa
```

| File | Functionality |
|---|---|
| `alb-controller-irsa.tf` | IAM role for AWS Load Balancer Controller |
| `cluster-autoscaler-irsa.tf` | IAM role for Cluster Autoscaler |
| `external-secrets-irsa.tf` | IAM role for External Secrets Operator |
| `ebs-csi-irsa.tf` | IAM role for EBS CSI Driver |
| `app-service-irsa.tf` | IAM role for application service account |
| `outputs.tf` | Exposes role ARNs for Helm add-ons |

## Add-ons module files

Path:

```text
modules/eks-addons
```

| File | Functionality |
|---|---|
| `providers.tf` | Connects Terraform to Kubernetes and Helm providers |
| `namespaces.tf` | Creates required namespaces |
| `metrics-server.tf` | Installs Metrics Server |
| `cluster-autoscaler.tf` | Installs Cluster Autoscaler |
| `aws-load-balancer-controller.tf` | Installs AWS Load Balancer Controller |
| `external-secrets.tf` | Installs External Secrets Operator |
| `prometheus-grafana.tf` | Installs Prometheus/Grafana stack |

## Application module files

Path:

```text
modules/helm-apps
```

| File | Functionality |
|---|---|
| `providers.tf` | Connects to EKS |
| `namespaces.tf` | Creates app namespaces |
| `apps.tf` | Deploys multiple apps using Helm `for_each` |
| `outputs.tf` | Exposes Helm release names |
