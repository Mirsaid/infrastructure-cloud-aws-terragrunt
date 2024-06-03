# Terraform Outputs

# VPC ID Output
output "vpc_id" {
  value = aws_vpc.this.id  # Output the ID of the created VPC
}

# Private Subnet IDs Output
output "private_subnet_ids" {
  value = aws_subnet.private[*].id  # Output the IDs of the created private subnets
}

# Public Subnet IDs Output
output "public_subnet_ids" {
  value = aws_subnet.public[*].id  # Output the IDs of the created public subnets
}

# Securty Groups IDs Output
output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id
}
output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "efs_sg_id" {
  value = aws_security_group.efs_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}