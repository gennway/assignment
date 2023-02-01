locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  env              = local.environment_vars.locals.environment
  project_name     = local.environment_vars.locals.project_name
  region           = local.region_vars.locals.aws_region
}


terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-ecs//.?ref=699b7f7b653a16dd81c4242660efdf70bd184bd9"
}


inputs = {
  cluster_name = "${local.project_name}-${local.env}"
  cluster_configuration = {
    execute_command_configuration = {
      logging = "OVERRIDE"
      log_configuration = {
        cloud_watch_log_group_name = "/aws/ecs/aws-ec2"
      }

    }
  }
  cluster_settings = {
    "name" : "containerInsights",
    "value" : "enabled"
  }
  tags = {
    Environment = local.env
    Project     = local.project_name
  }
}