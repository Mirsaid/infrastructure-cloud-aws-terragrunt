# Terraform configuration specifying required version and AWS provider
terraform {
  required_version = ">= 1.0"  # Minimum Terraform version required

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.9.0"  # AWS provider version constraint
    }
  }
}
