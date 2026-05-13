# 06 - Troubleshooting Guide

## 1. Terraform backend bucket does not exist

Error:

```text
S3 bucket does not exist
```

Fix:

```powershell
.\scripts\Invoke-TerraformLayer.ps1 -Environment dev -Layer 00-backend -Action apply
```

Then update `backend.hcl` files with the created bucket name.

## 2. Kubernetes provider tries localhost

Error:

```text
Get "http://localhost/apis/...": connect: connection refused
```

Meaning:

Terraform could not configure Kubernetes/Helm provider properly.

Checks:

```powershell
aws eks update-kubeconfig --region ap-south-1 --name <cluster-name>
kubectl get nodes
aws sts get-caller-identity
```

Also make sure `03-cluster` and `04-node-groups` are already applied before `06-addons`.

## 3. No nodes visible

Check:

```powershell
kubectl get nodes
kubectl get pods -A
aws eks describe-cluster --name <cluster-name> --region ap-south-1
```

Possible causes:
- Node group not created
- aws-auth/access entry issue
- Private node networking issue
- NAT Gateway missing for private subnet egress
- Security group issue

## 4. Metrics Server not working

Check:

```powershell
kubectl get deployment metrics-server -n kube-system
kubectl logs deployment/metrics-server -n kube-system
kubectl top nodes
```

If `kubectl top` fails, Metrics Server is not healthy.

## 5. Cluster Autoscaler not scaling

Check:

```powershell
kubectl logs deployment/cluster-autoscaler -n kube-system
kubectl get pods -A | Select-String Pending
```

Possible causes:
- Missing IRSA annotation
- IAM policy missing permissions
- Node group tags missing
- Pods cannot fit due to taints, node selectors, or resource requests

## 6. ALB Controller webhook error

Error:

```text
no endpoints available for service aws-load-balancer-webhook-service
```

Fix:

```powershell
kubectl get pods -n kube-system | Select-String aws-load-balancer
kubectl logs deployment/aws-load-balancer-controller -n kube-system
```

Possible causes:
- Controller not running
- IRSA permission issue
- Helm release failed
- Service account annotation missing

## 7. ECR image pull issue

Check:

```powershell
kubectl describe pod <pod-name> -n <namespace>
aws ecr describe-repositories --region ap-south-1
```

Possible causes:
- Image tag does not exist
- Node IAM permissions issue
- Private subnet cannot reach ECR
- ECR VPC endpoints missing and NAT unavailable

## 8. Pod pending

Check:

```powershell
kubectl describe pod <pod-name> -n <namespace>
kubectl get nodes
kubectl top nodes
```

Possible causes:
- Insufficient CPU/memory
- PVC not bound
- Node selector mismatch
- Taints not tolerated
- Cluster Autoscaler issue
