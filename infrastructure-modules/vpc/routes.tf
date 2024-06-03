# AWS Private Route Table Configuration
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id  # Associate with the VPC

  route {
    cidr_block     = "0.0.0.0/0"  # Default route to NAT Gateway for private subnets
    nat_gateway_id = aws_nat_gateway.this.id
  }
  route {
    cidr_block = "192.168.0.0/16"
    transit_gateway_id = data.aws_ec2_transit_gateway.tgw.id
  }
  route {
    cidr_block = "10.0.0.0/16"
    transit_gateway_id = data.aws_ec2_transit_gateway.tgw.id
  }

  tags = {
    Name = "${var.env}-private"  # Name tag for identification
  }
}

# AWS Public Route Table Configuration
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id  # Associate with the VPC

  route {
    cidr_block = "0.0.0.0/0"  # Default route to Internet Gateway for public subnets
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "${var.env}-public"  # Name tag for identification
  }
}

# AWS Private Route Table Association
resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)  # Associate private route table with private subnets

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# AWS Public Route Table Association
resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)  # Associate public route table with public subnets

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
