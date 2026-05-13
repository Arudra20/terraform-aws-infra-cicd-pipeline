# 03 - PowerShell Execution Guide

This repo is written so you can operate it from Windows PowerShell.

## 1. Prerequisites

Install:

```powershell
terraform version
aws --version
kubectl version --client
helm version
git --version
```

Then verify AWS access:

```powershell
aws sts get-caller-identity
```

If this fails, fix AWS CLI credentials before running Terraform.

## 2. Recommended terminal

Use PowerShell 7+ if possible.

```powershell
$PSVersionTable.PSVersion
```

## 3. Validate tooling

```powershell
.\scripts\Test-Prerequisites.ps1
```

## 4. First-time backend creation

```powershell
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 00-backend -Action apply
```

After backend is created, copy the bucket name into every backend file:

```text
envs/dev/01-network/backend.hcl
envs/dev/02-registry/backend.hcl
envs/dev/03-cluster/backend.hcl
...
```

## 5. Apply one layer

```powershell
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 01-network -Action plan
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 01-network -Action apply
```

## 6. Apply all layers in order

```powershell
.\scripts\Invoke-FullApply.ps1 -Environment dev
```

## 7. Destroy sequence

Destroy in reverse order:

```powershell
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 07-apps -Action destroy
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 06-addons -Action destroy
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 05-irsa -Action destroy
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 04-node-groups -Action destroy
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 03-cluster -Action destroy
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 02-registry -Action destroy
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 01-network -Action destroy
```

Destroy backend last only if you no longer need Terraform state.

## 8. kubeconfig update

After EKS cluster is created:

```powershell
aws eks update-kubeconfig `
  --region ap-south-1 `
  --name your-project-dev-eks
```

Then verify:

```powershell
kubectl get nodes
kubectl get pods -A
```

## 9. Validate add-ons

```powershell
kubectl get pods -n kube-system
kubectl get deployment metrics-server -n kube-system
kubectl get deployment cluster-autoscaler -n kube-system
kubectl logs deployment/cluster-autoscaler -n kube-system
kubectl top nodes
kubectl top pods -A
```

## 10. Common PowerShell mistakes

### Multiline commands

Use backtick:

```powershell
aws eks update-kubeconfig `
  --region ap-south-1 `
  --name my-cluster
```

### Environment variables

PowerShell uses:

```powershell
$env:AWS_REGION = "ap-south-1"
$env:AWS_PROFILE = "default"
```

Not:

```bash
export AWS_REGION=ap-south-1
```

### Paths

Use:

```powershell
cd .\envs\dev\01-network
```

not Linux-style paths unless using WSL.
