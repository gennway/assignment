locals {
  app_vars = read_terragrunt_config(find_in_parent_folders("app.hcl"))
  app_name = local.app_vars.locals.app
  app_port = local.app_vars.locals.port
}
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/ecs-service.hcl"
}
dependency "alb" {
  config_path = "../ALB"
}

dependency "sg" {
  config_path = "../../../security-groups/app-kafka"

}

include "config" {
  path = find_in_parent_folders()
}




inputs = {
  ignore_changes_task_definition = true
  desired_count = "1"
  ecs_load_balancers = TO_BE_ADDED
  security_group_ids = [dependency.sg.outputs.security_group_id]
}