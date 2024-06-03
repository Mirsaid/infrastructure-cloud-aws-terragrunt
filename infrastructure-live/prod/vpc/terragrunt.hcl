# Main Terraform Configuration

# Source for VPC module
terraform {
  source = "../../../infrastructure-modules/vpc"
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

# Inputs for VPC module
inputs = {
  env             = include.env.locals.env
  azs             = ["us-west-1a", "us-west-1b"]
  private_subnets = ["10.2.0.0/19", "10.2.32.0/19"]
  public_subnets  = ["10.2.64.0/19", "10.2.96.0/19"]
  vpc_cidr_block  = "10.2.0.0/16"
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/production"  = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb"         = 1
    "kubernetes.io/cluster/production" = "shared"
  }
}
