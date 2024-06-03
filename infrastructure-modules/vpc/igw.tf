# AWS Internet Gateway Configuration
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id  # Associate the Internet Gateway with the specified VPC

  tags = {
    Name = "${var.env}-igw"  # Name tag for identification
  }
}
