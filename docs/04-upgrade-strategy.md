# 04 - Upgrade Strategy

## 1. Why upgrades are separated

The repo is built so you do not upgrade everything at once.

Bad style:

```text
Change VPC, EKS, nodes, controllers, and apps in one Terraform apply.
```

Good style:

```text
Upgrade one layer.
Validate.
Move to next layer.
```

## 2. EKS control plane upgrade

Layer:

```text
envs/dev/03-cluster
```

Steps:

```powershell
# Update cluster_version in envs/dev/03-cluster/terraform.tfvars
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 03-cluster -Action plan
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 03-cluster -Action apply
```

Validate:

```powershell
aws eks describe-cluster --name your-cluster --region ap-south-1 --query "cluster.version"
kubectl version
kubectl get pods -A
```

## 3. EKS managed add-ons upgrade

EKS managed add-ons are in:

```text
modules/eks-cluster/cluster-addons.tf
```

They include:
- CoreDNS
- kube-proxy
- VPC CNI
- EBS CSI Driver

Upgrade by changing addon versions or `most_recent` behavior in the cluster module.

## 4. Node group upgrade

Layer:

```text
envs/dev/04-node-groups
```

Safer approach:

1. Add a new node group with new AMI/instance type.
2. Apply node group layer.
3. Cordon old nodes.
4. Drain old nodes.
5. Remove old node group from variables.
6. Apply again.

Commands:

```powershell
kubectl get nodes
kubectl cordon <old-node-name>
kubectl drain <old-node-name> --ignore-daemonsets --delete-emptydir-data
```

## 5. Metrics Server upgrade

Layer:

```text
envs/dev/06-addons
```

Variable:

```hcl
metrics_server_chart_version = "x.y.z"
```

Apply only add-ons:

```powershell
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 06-addons -Action apply
```

Validate:

```powershell
kubectl get deployment metrics-server -n kube-system
kubectl top nodes
```

## 6. Cluster Autoscaler upgrade

Layer:

```text
envs/dev/06-addons
```

Variable:

```hcl
cluster_autoscaler_chart_version = "x.y.z"
```

Validate:

```powershell
kubectl logs deployment/cluster-autoscaler -n kube-system
kubectl get pods -n kube-system | Select-String cluster-autoscaler
```

## 7. Application upgrade

Layer:

```text
envs/dev/07-apps
```

Update only image tag:

```hcl
image_tag = "new-git-sha"
```

Apply:

```powershell
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 07-apps -Action apply
```

Validate:

```powershell
kubectl rollout status deployment/<app-name> -n <namespace>
kubectl get pods -n <namespace>
```
