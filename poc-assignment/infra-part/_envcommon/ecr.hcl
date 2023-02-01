
locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  app_vars = read_terragrunt_config(find_in_parent_folders("app.hcl"))
  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment
  project_name = local.environment_vars.locals.project_name
  region   = local.region_vars.locals.aws_region
  app_name = local.app_vars.locals.app
  role_arn = local.app_vars.locals.role
  app_version = local.app_vars.locals.version
}

terraform {
  source = "github.com/cloudposse/terraform-aws-ecr//.?ref=0472d649275df45dfd47514275e69792d1567d08"
}

inputs = {
  namespace               = ""
  environment             = local.env
  stage                   = ""
  name                    = local.app_name
  use_fullname            = false
  scan_images_on_push     = false
  image_tag_mutability    = "MUTABLE"
  image_names             = ["${local.app_name}-${local.env}"]
  enable_lifecycle_policy = false
}


