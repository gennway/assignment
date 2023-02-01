locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  # Extract out common variables for reuse
  env          = local.environment_vars.locals.environment
  project_name = local.environment_vars.locals.project_name
  region       = local.region_vars.locals.aws_region

}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group?ref=v4.16.2"
}

dependency "vpc" {
  config_path = "../../vpc"
}

inputs = {

  vpc_id = dependency.vpc.outputs.vpc_id

}
