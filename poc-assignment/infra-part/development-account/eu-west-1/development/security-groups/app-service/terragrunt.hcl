
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/security-group.hcl"
}

include "config" {
  path = find_in_parent_folders()
}


dependency "alb" {
  config_path = "../alb-grpc-app"
}

inputs = {
  name         = "GRPC APP"
  description  = "Security group for GRPC APP (ECS)"
  egress_rules = ["all-all"]

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = dependency.alb.outputs.security_group_id
    },
    {
      rule                     = "https-443-tcp"
      source_security_group_id = dependency.alb.outputs.security_group_id
    },
    {
      from_port                = 8080
      to_port                  = 8080
      protocol                 = 6
      description              = "Application port (required for Healh check)"
      source_security_group_id = dependency.alb.outputs.security_group_id
    },
    {
      from_port                = 9000
      to_port                  = 9000
      protocol                 = 6
      description              = "Application port (required for Healh check)"
      source_security_group_id = dependency.alb.outputs.security_group_id
    },

  ]
  number_of_computed_ingress_with_source_security_group_id = 3
}
