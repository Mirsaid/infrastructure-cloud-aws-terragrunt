# Outputs for EKS Configuration

# EKS Cluster Name Output
output "eks_name" {
  value = aws_eks_cluster.this.name  # Output the name of the EKS cluster
}

# OpenID Connect Provider ARN Output for IRSA
output "openid_provider_arn" {
  value = aws_iam_openid_connect_provider.this[0].arn  # Output the ARN of the OpenID Connect provider for IRSA
}
