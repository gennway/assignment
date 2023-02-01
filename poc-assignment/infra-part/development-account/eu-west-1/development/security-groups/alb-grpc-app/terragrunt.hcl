
include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/security-group.hcl"
}

include "config" {
  path = find_in_parent_folders()
}



inputs = {
  name        = "ALB GRPC"
  description = "Security group for GRPC-APP ALB"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]
  egress_rules        = ["all-all"]
}
