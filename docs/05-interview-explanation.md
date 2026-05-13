# 05 - Interview Explanation

## Explain the project

You can say:

> I designed the Terraform project using a layered structure. Instead of keeping all resources in a single root module, I separated the infrastructure into backend, network, registry, EKS cluster, node groups, IRSA, add-ons, and application stacks. Each layer has its own Terraform backend state, so changes can be applied independently with reduced blast radius.

## Explain module segregation

> Inside each module, I split files by functionality. For example, in the VPC module I have separate files for VPC, subnets, NAT Gateway, route tables, VPC endpoints, and flow logs. This does not make Terraform execute them separately, but it improves readability, code ownership, reviews, and upgrade planning.

## Explain why node groups are separate from cluster

> I keep node groups separate from the EKS control plane because node upgrades happen more frequently. For example, if I need to change instance type, AMI, disk size, or scaling values, I can update only the node group layer without modifying the EKS control plane.

## Explain EKS add-ons

> I manage AWS-native EKS add-ons like CoreDNS, kube-proxy, VPC CNI, and EBS CSI at the cluster layer because they are tightly coupled with the EKS version. I manage Helm-based platform add-ons like Metrics Server, Cluster Autoscaler, AWS Load Balancer Controller, and monitoring separately because they are upgraded more frequently.

## Explain Metrics Server

> Metrics Server collects CPU and memory metrics from kubelets and exposes them through the Kubernetes Metrics API. It is required for `kubectl top` and HPA CPU/memory-based scaling.

## Explain Cluster Autoscaler

> HPA increases pod replicas based on metrics. But if there is not enough worker node capacity, pods remain Pending. Cluster Autoscaler watches for unschedulable pods and increases the Auto Scaling Group or managed node group size so new nodes can join the cluster.

## Explain IRSA

> IRSA allows Kubernetes service accounts to assume AWS IAM roles. Instead of storing AWS keys inside pods, each controller or application gets only the IAM permissions it needs. For example, Cluster Autoscaler gets permissions to describe and update Auto Scaling Groups, while External Secrets gets permissions to read AWS Secrets Manager.

## Explain flow

> First, I create the S3 backend. Then I provision networking with VPC, public/private subnets, NAT, and routing. Next, I create ECR repositories. Then I create the EKS control plane and managed add-ons. After that, I create node groups, configure IRSA roles, install platform add-ons using Helm, and finally deploy application Helm charts.
