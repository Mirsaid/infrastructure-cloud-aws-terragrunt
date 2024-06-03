# Terraform Variables

# Environment name
variable "env" {
  description = "Environment name."
  type        = string
}

# Desired Kubernetes master version
variable "eks_version" {
  description = "Desired Kubernetes master version."
  type        = string
}


variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

# List of subnet IDs. Must be in at least two different availability zones.
variable "subnet_ids" {
  description = "List of subnet IDs. Must be in at least two different availability zones."
  type        = list(string)
}

# List of IAM Policies to attach to EKS-managed nodes.
variable "node_iam_policies" {
  description = "List of IAM Policies to attach to EKS-managed nodes."
  type        = map(any)
  default = {
    1 = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
    2 = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    3 = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
    4 = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    5 = "arn:aws:iam::060920925326:policy/ElasticFileSystemNodeAccess"
  }
}

# EKS node groups
variable "node_groups" {
  description = "EKS node groups"
  type        = map(any)
}

# Determines whether to create an OpenID Connect Provider for EKS to enable IRSA
variable "enable_irsa" {
  description = "Determines whether to create an OpenID Connect Provider for EKS to enable IRSA"
  type        = bool
  default     = true
}

variable "efs_results_id" {
  type = string
}

variable "efs_appdata_id" {
  type = string
}

variable "efs_matlab_id" {
  type = string
}

variable "instance_type" {
  type = string
  default = "t3.medium"
}