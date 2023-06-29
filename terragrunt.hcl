terraform {
  source = "github.com/yegorovev/tf_aws_terraform_state.git"

  //  before_hook "tfsec" {
  //    commands = ["plan", "apply"]
  //    execute  = ["tfsec", "."]
  //  }
}

locals {
  env_vars    = read_terragrunt_config("common.hcl").inputs
  profile     = local.env_vars.profile
  region      = local.env_vars.region
  bucket_name = local.env_vars.bucket_name
  lock_table  = local.env_vars.lock_table
  tags        = jsonencode(local.env_vars.tags)
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  profile = "${local.profile}"
  region  = "${local.region}"
  default_tags {
    tags = jsondecode(<<INNEREOF
${local.tags}
INNEREOF
)
  }
}
EOF
}

inputs = {
  bucket_name = local.bucket_name
  lock_table  = local.lock_table
}