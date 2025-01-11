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
  source = "../../../../modules/asg"
}

dependency "security_group" {
  config_path = "../security_group"
}

dependency "subnet" {
  config_path = "../subnet"
}

inputs = {
  name_prefix = local.account_name
  environment = local.environment

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 5
  private_subnet_ids = dependency.subnet.outputs.private_subnet_ids
  security_group_id  = dependency.security_group.outputs.security_group_id
}
