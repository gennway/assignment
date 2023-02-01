locals {
  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  # Extract out common variables for reuse
  env = local.environment_vars.locals.environment



  region = local.region_vars.locals.aws_region
}

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc//.?refaa61bc4346e1c430df8ec163ae9799d57df4af20"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()


}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  create_vpc         = true
  create_igw         = true
  enable_nat_gateway = true
  name               = "assignment"
  vpc_name           = "assignment-VPC-Main"
  igw_name           = "assignment-IGW-Main"
  cidr               = "192.168.0.0/16"
  azs                = ["${local.region}a"]
  public_subnets     = ["192.168.16.0/20"]
  private_subnets    = ["192.168.48.0/20"]
  database_subnets   = ["192.168.80.0/20"]
  kafka_subnets      = ["192.168.112.0/20"]
}
