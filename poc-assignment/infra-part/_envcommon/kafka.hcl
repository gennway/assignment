locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env              = local.environment_vars.locals.environment
  project_name     = local.environment_vars.locals.project_name
  region           = local.region_vars.locals.aws_region
}


terraform {
  source = "github.com/clowdhaus/terraform-aws-msk-kafka-cluster//.?ref=89281594c7d16aeb09b033e641f5e6c30855c71f"
}


inputs = {
 TO_BE_ADDED
}