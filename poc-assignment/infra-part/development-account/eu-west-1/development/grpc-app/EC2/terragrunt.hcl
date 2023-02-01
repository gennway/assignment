include "envcommon" {
  path = "${dirname(find_in_parent_folders())}/_envcommon/ec2.hcl"
}
include "config" {
  path = find_in_parent_folders()
}

dependency "sg" {
  config_path = "../../../security-groups/bastion-host"

}

inputs = {
  name            = "bastion-host"
  security_groups = [dependency.sg.outputs.security_group_id]
}