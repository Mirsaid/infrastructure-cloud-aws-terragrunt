# Remote State Configuration
remote_state {
  backend = "s3"
  generate = {
    path      = "state.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    profile = "profile_name"
    role_arn = "arn:aws:iam::xxx:role/user_name"
    bucket = "s3bucket_name-terraform-state"

    key = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
  provider "aws" {
  region  = "us-west-1"
  profile = "profile_name"
  
  assume_role {
    
    role_arn = "arn:aws:iam::xxx:role/user_name"
  }
}
EOF
}