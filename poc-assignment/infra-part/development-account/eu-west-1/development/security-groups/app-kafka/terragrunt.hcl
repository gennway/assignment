
include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/security-group.hcl"
}

include "config" {
  path = find_in_parent_folders()
}


dependency "app-sg" {
  config_path = "../app-service"
}

inputs = {
  name                = "Kafka SG"
  description         = "Security group for Kafka"
  egress_rules        = ["all-all"]

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "kafka-broker-tcp"
      source_security_group_id = dependency.app-sg.outputs.security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1
}
