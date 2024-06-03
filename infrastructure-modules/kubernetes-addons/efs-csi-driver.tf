# Data source to fetch OpenID Connect Provider details
data "aws_iam_openid_connect_provider" "this" {
  arn = var.openid_provider_arn
}

data "aws_iam_policy_document" "efs_csi_driver_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.this.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringLike"
      variable = "${replace(data.aws_iam_openid_connect_provider.this.url, "https://", "")}:sub"

      values = ["system:serviceaccount:kube-system:efs-csi-*"]
    }

    condition {
      test     = "StringLike"
      variable = "${replace(data.aws_iam_openid_connect_provider.this.url, "https://", "")}:aud"

      values = ["sts.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "efs_csi_driver_role" {
  name               = "${var.eks_name}-AmazonEKS_EFS_CSI_DriverRole"
  assume_role_policy = data.aws_iam_policy_document.efs_csi_driver_trust.json
}
resource "aws_iam_role_policy_attachment" "efs_csi_driver_policy_attachment" {
  role       = aws_iam_role.efs_csi_driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
}

resource "helm_release" "efs_controller" {
  name       = "aws-efs-csi-driver"
  chart      = "aws-efs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-efs-csi-driver/"
  version    = "2.5.6"
  namespace  = "kube-system"

  values = [
    <<EOF
clusterName: ${var.eks_name}
controller:
  create: true
  deleteAccessPointRootDir: true
  serviceAccount:
    name: efs-csi-controller-sa
    annotations:
      eks.amazonaws.com/role-arn: ${aws_iam_role.efs_csi_driver_role.arn}
  tags:
    efs.csi.aws.com/cluster: <cluster-name>
node:
  serviceAccount:
    name: efs-csi-node-sa
    annotations:
      eks.amazonaws.com/role-arn: ${aws_iam_role.efs_csi_driver_role.arn}
EOF
  ]
}