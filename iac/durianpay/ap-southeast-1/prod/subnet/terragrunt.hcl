locals {
  # AWS Account ID
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  # Environment (dev/stg/prod)
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  account_name     = local.account_vars.locals.account_name
  environment      = local.environment_vars.locals.environment
}


include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../modules/subnet"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  name_prefix = local.account_name
  environment = local.environment

  vpc_id              = dependency.vpc.outputs.vpc_id
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zones  = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}
