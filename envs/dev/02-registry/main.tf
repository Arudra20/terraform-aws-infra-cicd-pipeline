module "ecr" {
  source = "../../../modules/ecr"

  project_name = var.project_name
  environment  = var.environment
  repositories = var.repositories

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
