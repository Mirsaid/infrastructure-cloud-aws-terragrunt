
resource "aws_security_group_rule" "ingress_ng_vpn_traffic" {
  type = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "all"
  security_group_id        = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  cidr_blocks       = ["192.168.0.0/16"]
}

resource "aws_security_group_rule" "ingress_ng_vpc_traffic" {
  type = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "all"
  security_group_id        = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
  cidr_blocks       = ["10.0.0.0/8"]
}
