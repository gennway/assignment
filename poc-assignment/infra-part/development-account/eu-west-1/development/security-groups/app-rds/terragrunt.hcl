
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/security-group.hcl"
}

include "config" {
  path = find_in_parent_folders()
}

dependency "app-sg" {
  config_path = "../app-service"
}

dependency "bastion-sg" {
  config_path = "../app-service"
}
inputs = {
  name         = "RDS for GRPC Service"
  description  = "Security group for RDS that allows app service to connect"
  egress_rules = ["all-all"]

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "postgresql-tcp"
      source_security_group_id = dependency.app-sg.outputs.security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = dependency.bastion-sg.outputs.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 2
}
