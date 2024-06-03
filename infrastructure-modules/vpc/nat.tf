# AWS Elastic IP Configuration for NAT Gateway
resource "aws_eip" "this" {
  domain = "vpc"  # Allocate Elastic IP in the VPC domain

  tags = {
    Name = "${var.env}-nat"  # Name tag for identification
  }
}

# AWS NAT Gateway Configuration
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id  # Associate the NAT Gateway with the allocated Elastic IP
  subnet_id     = aws_subnet.public[0].id  # Associate the NAT Gateway with the first public subnet

  tags = {
    Name = "${var.env}-nat"  # Name tag for identification
  }

  depends_on = [aws_internet_gateway.this]  # Ensure Internet Gateway is created before NAT Gateway
}
