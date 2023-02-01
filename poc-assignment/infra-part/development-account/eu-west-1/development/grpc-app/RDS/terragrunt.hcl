locals {
  app_vars = read_terragrunt_config(find_in_parent_folders("app.hcl"))
  app_name = local.app_vars.locals.app
}
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/rds.hcl"
}


include "config" {
  path = find_in_parent_folders()
}

dependency "sg" {
  config_path = "../../../security-groups/app-rds"

}

inputs = {
  db_name                     = "assigment"
  vpc_security_group_ids      = [dependency.sg.outputs.security_group_id]
}