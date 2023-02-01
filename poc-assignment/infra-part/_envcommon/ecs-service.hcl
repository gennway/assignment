locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  app_vars         = read_terragrunt_config(find_in_parent_folders("app.hcl"))
  # Extract out common variables for reuse
  env          = local.environment_vars.locals.environment
  project_name = local.environment_vars.locals.project_name
  region       = local.region_vars.locals.aws_region
  app_name     = local.app_vars.locals.app
  app_port     = local.app_vars.locals.port
  role_arn     = local.app_vars.locals.role
  app_version  = local.app_vars.locals.version
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "github.com/cloudposse/terraform-aws-ecs-alb-service-task//.?ref=14008fc2491eb31b03567ea98e319e90340546d6"
}


dependency "vpc" {
  config_path = "../../../vpc"
}

dependency "ecs" {
  config_path = "../../../ecs/cluster"
}
inputs = {
  name                      = "${local.app_name}-${local.env}"
  exec_enabled              = true
  container_definition_json = <<EOL
[
        {
            "name": "${local.app_name}",
            "image": "placeholder",
            "portMappings": [
                {
                    "name": "http-8080-tcp",
                    "containerPort": 8080,
                    "hostPort": 8080,
                    "protocol": "tcp",
                    "appProtocol": "http"
                },
                {
                    "name": "grpc-9000-tcp",
                    "containerPort": 9000,
                    "hostPort": 9000,
                    "protocol": "tcp",
                    "appProtocol": "grpc"
                }
            ],
            
        }
    ]
EOL
  ecs_cluster_arn           = dependency.ecs.outputs.cluster_arn
  launch_type               = "FARGATE"
  vpc_id                    = dependency.vpc.outputs.vpc_id
  security_group_ids        = [dependency.vpc.outputs.default_security_group_id]
  subnet_ids                = dependency.vpc.outputs.private_subnets
  assign_public_ip          = "false"
  role_tags_enabled         = "false"
  security_group_enabled    = "false"
  task_role_arn             = [local.role_arn]
  task_exec_role_arn        = [local.role_arn]
  propagate_tags            = "TASK_DEFINITION"
}