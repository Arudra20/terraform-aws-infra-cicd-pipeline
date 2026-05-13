# EKS managed add-ons are defined in locals.tf as local.eks_managed_addons.
# These are tightly coupled with cluster lifecycle and Kubernetes version.
#
# coredns              -> DNS resolution inside Kubernetes
# kube-proxy           -> Service networking
# vpc-cni              -> Pod networking through AWS VPC CNI
# aws-ebs-csi-driver   -> EBS persistent volume support
