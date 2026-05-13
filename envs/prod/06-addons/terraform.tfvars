aws_region   = "ap-south-1"          # AWS region where resources will be created.
project_name = "sample-eks-platform" # Change this for each new project; used in naming/tags.
environment  = "prod"                # Current environment name; keeps names and state paths isolated.
state_bucket = "__TF_STATE_BUCKET__" # Replace after running 00-backend.

enable_metrics_server        = true # Required for kubectl top and HPA CPU/memory metrics.
metrics_server_chart_version = null # Keep null for latest chart from repo; pin value for controlled production upgrades.

enable_cluster_autoscaler        = true # Scales worker nodes when pods are Pending due to insufficient capacity.
cluster_autoscaler_chart_version = null # Pin chart version for production change control.

enable_aws_load_balancer_controller        = true # Required for Kubernetes Ingress to create AWS ALB/NLB.
aws_load_balancer_controller_chart_version = null # Pin version during production upgrades.

enable_external_secrets        = true # Syncs AWS Secrets Manager values into Kubernetes secrets.
external_secrets_chart_version = null # Pin version for predictable releases.

enable_monitoring_stack             = false # Set true to install Prometheus/Grafana stack.
kube_prometheus_stack_chart_version = null  # Pin version if monitoring stack is enabled.
