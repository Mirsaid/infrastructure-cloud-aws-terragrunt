# AWS Private Subnet Configuration
resource "aws_subnet" "private" {
  count = length(var.private_subnets)  # Create private subnets based on the specified CIDR blocks

  vpc_id            = aws_vpc.this.id  # Associate with the VPC
  cidr_block        = var.private_subnets[count.index]  # CIDR block for the private subnet
  availability_zone = var.azs[count.index]  # Specify the availability zone for the subnet

  tags = merge(
    { Name = "${var.env}-private-${var.azs[count.index]}" },  # Name tag for identification
    var.private_subnet_tags  # Additional tags for private subnets
  )
}

# AWS Public Subnet Configuration
resource "aws_subnet" "public" {
  count = length(var.public_subnets)  # Create public subnets based on the specified CIDR blocks

  vpc_id            = aws_vpc.this.id  # Associate with the VPC
  cidr_block        = var.public_subnets[count.index]  # CIDR block for the public subnet
  availability_zone = var.azs[count.index]  # Specify the availability zone for the subnet

  tags = merge(
    { Name = "${var.env}-public-${var.azs[count.index]}" },  # Name tag for identification
    var.public_subnet_tags  # Additional tags for public subnets
  )
}
