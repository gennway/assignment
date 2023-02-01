
locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  app_vars         = read_terragrunt_config(find_in_parent_folders("app.hcl"))
  env          = local.environment_vars.locals.environment
  project_name = local.environment_vars.locals.project_name
  region       = local.region_vars.locals.aws_region
  app_name     = local.app_vars.locals.app
  role_arn     = local.app_vars.locals.role
  app_version  = local.app_vars.locals.version
}


terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-alb//.?ref=6cde6adf0d625b4c9a89c192bca5c26dcd94aedd"
}

dependency "vpc" {
  config_path = "../../../vpc"
}

inputs = {
  name               = "${local.app_name}-${local.env}-alb"
  load_balancer_type = "application"
  vpc_id             = dependency.vpc.outputs.vpc_id
  subnets            = dependency.vpc.outputs.public_subnets

  target_groups = TO_BE_ADDED

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = TO_BE_ADDED
    }
  ]


  tags = {
    Environment = local.env
  }
}


