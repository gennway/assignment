
include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/security-group.hcl"
}

include "config" {
  path = find_in_parent_folders()
}



inputs = {
  name        = "Bastion Host"
  description = "Security group for Bastion Host"
  ingress_cidr_blocks = TO_BE_ADDED
  ingress_rules       = ["ssh-tcp"]
  egress_rules        = ["all-all"]
}
