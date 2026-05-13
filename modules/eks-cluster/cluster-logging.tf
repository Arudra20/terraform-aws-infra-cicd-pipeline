# EKS control plane logs are controlled by var.enabled_cluster_log_types.
# Common production values:
# ["api", "audit", "authenticator", "controllerManager", "scheduler"]
#
# api             -> API server calls
# audit           -> security/audit trail
# authenticator   -> IAM authentication logs
# scheduler       -> pod scheduling decisions
# controllerManager -> controller reconciliation logs
