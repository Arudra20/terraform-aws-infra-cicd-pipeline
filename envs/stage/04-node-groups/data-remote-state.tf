data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket
    key          = "stage/01-network/terraform.tfstate"
    region       = var.aws_region
    use_lockfile = true
  }
}

data "terraform_remote_state" "cluster" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket
    key          = "stage/03-cluster/terraform.tfstate"
    region       = var.aws_region
    use_lockfile = true
  }
}
