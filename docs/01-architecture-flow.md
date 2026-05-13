# 01 - Architecture and Provisioning Flow

## 1. Target platform

This template provisions an AWS EKS platform using layered Terraform stacks.

```text
Developer / CI/CD
    |
    | assumes AWS role using OIDC
    v
AWS IAM
    |
    v
Terraform layers
    |
    +--> S3 backend
    +--> VPC networking
    +--> ECR image registry
    +--> EKS control plane
    +--> EKS node groups
    +--> IRSA roles
    +--> Kubernetes add-ons
    +--> Application Helm releases
```

## 2. Why layers are separated

Each layer has a different lifecycle.

| Layer | Change frequency | Reason for separation |
|---|---:|---|
| Backend | Rare | State storage should be stable |
| Network | Rare | VPC/subnets are foundational and risky to change |
| Registry | Sometimes | Repos are added when services are added |
| Cluster | Occasionally | EKS version/control plane upgrades are controlled |
| Node groups | Often | Instance types, scaling, AMI upgrades change more often |
| IRSA | Often | Permissions change per add-on/application |
| Add-ons | Often | Controllers and monitoring tools are upgraded independently |
| Apps | Very often | Application releases happen frequently |

## 3. Full provisioning order

### Step 1: Backend

Creates S3 bucket for Terraform state.

```text
envs/dev/00-backend
```

This stack uses local state first because the backend does not exist yet.

### Step 2: Network

Creates VPC, subnets, route tables, NAT Gateway, Internet Gateway, VPC endpoints, and flow logs.

```text
envs/dev/01-network
```

Output values:
- `vpc_id`
- `public_subnet_ids`
- `private_subnet_ids`
- `private_route_table_ids`

### Step 3: Registry

Creates ECR repositories for microservice Docker images.

```text
envs/dev/02-registry
```

Output values:
- Repository URLs
- Repository ARNs

### Step 4: Cluster

Creates the EKS control plane.

```text
envs/dev/03-cluster
```

This layer consumes network outputs using remote state.

### Step 5: Node groups

Creates worker nodes separately from the cluster.

```text
envs/dev/04-node-groups
```

This makes node upgrades safer. You can create a new node group, drain old nodes, and remove the old node group.

### Step 6: IRSA

Creates IAM roles for Kubernetes service accounts.

```text
envs/dev/05-irsa
```

Used by:
- AWS Load Balancer Controller
- Cluster Autoscaler
- External Secrets Operator
- EBS CSI Driver
- Application service accounts

### Step 7: Add-ons

Installs platform add-ons through Helm.

```text
envs/dev/06-addons
```

Includes:
- Metrics Server
- Cluster Autoscaler
- AWS Load Balancer Controller
- External Secrets Operator
- kube-prometheus-stack

### Step 8: Apps

Deploys application Helm charts.

```text
envs/dev/07-apps
```

## 4. Request flow after deployment

```text
User Browser
    |
    v
Route 53 DNS
    |
    v
AWS ALB
    |
    v
Kubernetes Ingress
    |
    v
Kubernetes Service
    |
    v
Application Pods on EKS worker nodes
```

## 5. Autoscaling flow

```text
Traffic increases
    |
    v
Pod CPU/memory increases
    |
    v
HPA scales pods
    |
    v
If no node capacity is available, pods become Pending
    |
    v
Cluster Autoscaler detects unschedulable pods
    |
    v
Auto Scaling Group increases node count
    |
    v
New node joins EKS
    |
    v
Pending pods get scheduled
```

## 6. Monitoring flow

```text
Kubelet / cAdvisor / Kubernetes API
    |
    v
Metrics Server
    |
    +--> kubectl top
    +--> HPA resource metrics

Prometheus
    |
    +--> Scrapes Kubernetes metrics
    +--> Scrapes application metrics
    |
    v
Grafana dashboards
```
