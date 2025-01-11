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
  source = "../../../../modules/cloudwatch"
}

dependency "asg" {
  config_path = "../asg"
}


inputs = {
  name_prefix = local.account_name
  environment = local.environment

  autoscaling_group_name = dependency.asg.outputs.autoscaling_group_name
}
