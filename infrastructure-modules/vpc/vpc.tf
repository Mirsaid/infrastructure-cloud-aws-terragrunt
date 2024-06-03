# AWS VPC Configuration
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr_block  # CIDR block for the VPC
  enable_dns_support   = true  # Enable DNS support
  enable_dns_hostnames = true  # Enable DNS hostnames

  tags = {
    Name = "${var.env}-vpc"  # Name tag for identification
  }
}
