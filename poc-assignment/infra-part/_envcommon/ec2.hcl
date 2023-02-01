locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env              = local.environment_vars.locals.environment
  project_name     = local.environment_vars.locals.project_name
  region           = local.region_vars.locals.aws_region
}


terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance//.?ref=f612ec14f996a378909dd2cd461118c1d272cf70"
}


inputs = {
 TO_BE_ADDED
}