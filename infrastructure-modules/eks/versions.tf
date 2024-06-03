# Terraform configuration file specifying the required Terraform version and providers.

terraform {
  required_version = ">= 1.0"  # Specify the minimum Terraform version required for this configuration.

  required_providers {
    aws = {
      source  = "hashicorp/aws"  # Specify the source of the AWS provider
      version = "~> 5.9.0"  # Use a version constraint for the AWS provider
    }
  }
}
