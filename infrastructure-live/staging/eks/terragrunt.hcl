# Main Terraform Configuration

# Source for EKS module
terraform {
  source = "../../../infrastructure-modules/eks"
}

# Include root configuration
include "root" {
  path = find_in_parent_folders()
}

# Include environment-specific configuration
include "env" {
  path           = find_in_parent_folders("env.hcl")
  expose         = true
  merge_strategy = "no_merge"
}

# Inputs for EKS module
inputs = {
  eks_version = "1.29"
  env         = include.env.locals.env
  subnet_ids  = dependency.vpc.outputs.private_subnet_ids
  instance_type =  "t3.medium" #"c5.xlarge"
  vpc_id = dependency.vpc.outputs.vpc_id
  node_groups = {
    staging-priceit-t3_medium = {
      capacity_type  = "ON_DEMAND"
      ami_type = "AL2_x86_64"
      scaling_config = {
        desired_size = 1
        max_size     = 4
        min_size     = 1
      }
    }
  }
}


# Dependency on VPC module
dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    private_subnet_ids = ["subnet-1234", "subnet-5678"]
  }
}
