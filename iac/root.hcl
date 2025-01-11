locals {
  # AWS Account ID
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Default region
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Environment (dev/stg/prod)
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  account_name     = local.account_vars.locals.account_name
  aws_account_id   = local.account_vars.locals.aws_account_id
  aws_region       = local.region_vars.locals.aws_region
  environment      = local.environment_vars.locals.environment
}

# Create terrafor provider (AWS)
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"

  # Only these AWS Account IDs may be operated on by this template
  allowed_account_ids = ["${local.aws_account_id}"]
}
EOF
}

# Generate remote state (store on s3)
remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket = "durianpay-tf-state"
    key = "${path_relative_to_include()}/terraform_state.tfstate"
    region = local.aws_region
  }

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}


inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
)
