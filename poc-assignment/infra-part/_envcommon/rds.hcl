locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  app_vars         = read_terragrunt_config(find_in_parent_folders("app.hcl"))
  env              = local.environment_vars.locals.environment
  project_name     = local.environment_vars.locals.project_name
  region           = local.region_vars.locals.aws_region
  app_name         = local.app_vars.locals.app
  role_arn         = local.app_vars.locals.role
  app_version      = local.app_vars.locals.version
}

terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-rds//.?ref=92bc43cca79cd02c1c9437d593f5995cff23d169"
}


dependency "vpc" {
  config_path = "../../../vpc"
}

inputs = {
  identifier = "${local.env}-${local.app_name}-db"

  engine                  = "postgres"
  engine_version          = "11.16"
  family                  = "postgres11"
  major_engine_version    = "11"
  instance_class          = "db.t2.small"
  storage_type            = "gp2"
  allocated_storage       = 40
  max_allocated_storage   = 200
  network_type            = "IPV4"
  username                = "qwerty"
  port                    = 5432
  db_subnet_group_name    = dependency.vpc.outputs.database_subnet_group
  multi_az                = false
  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false
}


