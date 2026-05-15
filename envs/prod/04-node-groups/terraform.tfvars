aws_region   = "ap-south-1"          # AWS region where resources will be created.
project_name = "eks-platform" # Change this for each new project; used in naming/tags.
environment  = "prod"                # Current environment name; keeps names and state paths isolated.
state_bucket = "eks-platform-prod" # Replace after running 00-backend.

node_groups = {
  general = {
    instance_types = ["m6i.large"] # Worker node EC2 instance type. Change based on workload CPU/memory.
    capacity_type  = "ON_DEMAND"   # ON_DEMAND for stable apps; SPOT for cost-optimized fault-tolerant workloads.
    disk_size      = 30            # Root disk size in GB for worker nodes.
    min_size       = 3             # Minimum nodes Cluster Autoscaler can scale down to.
    desired_size   = 4             # Initial node count. Terraform ignores later autoscaler drift.
    max_size       = 10            # Maximum nodes Cluster Autoscaler can scale up to.

    labels = {
      workload = "general" # Used by nodeSelector/affinity for workload placement.
    }

    taints = [] # Add taints when you want only specific pods to schedule here.
  }

  spot = {
    instance_types = ["t3.large", "m5.large", "m6i.large"] # Multiple types improve Spot availability.
    capacity_type  = "SPOT"                                # Lower cost; use for non-critical/stateless workloads.
    disk_size      = 30                                    # Root disk in GB.
    min_size       = 0                                     # Allows full scale-down when no Spot workload exists.
    desired_size   = 0                                     # Starts with zero Spot nodes.
    max_size       = 5                                     # Maximum Spot nodes.

    labels = {
      workload = "spot" # Workloads can target spot nodes using nodeSelector.
    }

    taints = [
      {
        key    = "capacity"    # Taint key.
        value  = "spot"        # Taint value.
        effect = "NO_SCHEDULE" # Only pods with matching toleration can run here.
      }
    ]
  }
}
