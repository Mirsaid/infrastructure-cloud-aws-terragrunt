# Environment name
variable "env" {
  description = "Environment name."
  type        = string
}

# Name of the cluster
variable "eks_name" {
  description = "Name of the cluster."
  type        = string
}

# IAM OpenID Connect Provider ARN
variable "openid_provider_arn" {
  description = "IAM OpenID Connect Provider ARN"
  type        = string
}
