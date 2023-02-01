include "envcommon" {
  path   = "${dirname(find_in_parent_folders())}/_envcommon/ecs-cluster.hcl"
  expose = true
}
