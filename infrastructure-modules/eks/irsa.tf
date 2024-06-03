# IRSA (IAM Roles for Service Accounts) Configuration

# Data source to fetch TLS certificate when IRSA is enabled
data "tls_certificate" "this" {
  count = var.enable_irsa ? 1 : 0  # Conditionally fetch TLS certificate if IRSA is enabled

  url = aws_eks_cluster.this.identity[0].oidc[0].issuer  # URL for the OIDC issuer
}

# IAM OpenID Connect Provider for IRSA
resource "aws_iam_openid_connect_provider" "this" {
  count = var.enable_irsa ? 1 : 0  # Conditionally create OpenID Connect Provider if IRSA is enabled

  client_id_list  = ["sts.amazonaws.com"]  # List of client IDs
  thumbprint_list = [data.tls_certificate.this[0].certificates[0].sha1_fingerprint]  # SHA-1 fingerprint of the TLS certificate
  url             = aws_eks_cluster.this.identity[0].oidc[0].issuer  # URL for the OIDC issuer
}
