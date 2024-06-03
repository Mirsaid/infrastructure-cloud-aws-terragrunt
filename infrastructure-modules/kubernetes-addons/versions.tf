# Terraform configuration specifying required version and Helm provider
terraform {
  required_version = ">= 1.0"  # Minimum Terraform version required

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.9"  # Helm provider version constraint
    }
    aws = {
      source  = "hashicorp/aws"  # Specify the source of the AWS provider
      version = "~> 5.9.0"  # Use a version constraint for the AWS provider
    }
  }
}
