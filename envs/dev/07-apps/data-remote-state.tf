data "terraform_remote_state" "cluster" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket
    key          = "dev/03-cluster/terraform.tfstate"
    region       = var.aws_region
    use_lockfile = true
  }
}

data "terraform_remote_state" "irsa" {
  backend = "s3"

  config = {
    bucket       = var.state_bucket
    key          = "dev/05-irsa/terraform.tfstate"
    region       = var.aws_region
    use_lockfile = true
  }
}
