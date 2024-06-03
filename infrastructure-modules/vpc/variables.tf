# Environment name
variable "env" {
  description = "Environment name."
  type        = string
}

# CIDR block for VPC
variable "vpc_cidr_block" {
  description = "CIDR (Classless Inter-Domain Routing) for VPC."
  type        = string
  default     = "10.1.0.0/16"
}

# Availability zones for subnets
variable "azs" {
  description = "Availability zones for subnets."
  type        = list(string)
}

# CIDR ranges for private subnets
variable "private_subnets" {
  description = "CIDR ranges for private subnets."
  type        = list(string)
}

# CIDR ranges for public subnets
variable "public_subnets" {
  description = "CIDR ranges for public subnets."
  type        = list(string)
}

# Tags for private subnets
variable "private_subnet_tags" {
  description = "Tags for private subnets."
  type        = map(any)
}

# Tags for public subnets
variable "public_subnet_tags" {
  description = "Tags for public subnets."
  type        = map(any)
}
