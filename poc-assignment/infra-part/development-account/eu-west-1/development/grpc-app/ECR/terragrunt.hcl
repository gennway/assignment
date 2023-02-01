include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/ecr.hcl"
}

include "config" {
  path = find_in_parent_folders()
}

inputs = {
}