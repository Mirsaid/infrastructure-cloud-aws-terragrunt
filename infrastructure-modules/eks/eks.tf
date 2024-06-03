# IAM Role for EKS Cluster
resource "aws_iam_role" "eks" {
  name = "${var.env}-eks-cluster"
  
  # AssumeRole policy for EKS
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "eks.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach Amazon EKS Cluster Policy
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks.name
}
resource "aws_iam_role_policy_attachment" "eks_logging_policy" {
  policy_arn = "arn:aws:iam::060920925326:policy/eks-development-logging-policy"
  role       = aws_iam_role.eks.name
}

# Amazon EKS Cluster
resource "aws_eks_cluster" "this" {
  name     = "${var.env}"
  version  = var.eks_version
  role_arn = aws_iam_role.eks.arn
  
  # VPC Configuration
  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = false
    subnet_ids              = var.subnet_ids
  }
    enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy,aws_iam_role_policy_attachment.eks_logging_policy]
}
