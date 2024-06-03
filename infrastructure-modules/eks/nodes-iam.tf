# IAM Role for EKS Nodes
resource "aws_iam_role" "nodes" {
  name = "${var.env}-eks-nodes"

  # AssumeRole policy for EC2 instances (EKS Nodes)
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = "sts:AssumeRole",
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

# Attach IAM policies to EKS Nodes IAM Role
resource "aws_iam_role_policy_attachment" "nodes" {
  for_each = var.node_iam_policies  # Attach policies specified in var.node_iam_policies

  policy_arn = each.value  # IAM policy ARN
  role       = aws_iam_role.nodes.name  # IAM Role for EKS Nodes
}
