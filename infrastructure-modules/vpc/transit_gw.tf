#data
data "aws_ec2_transit_gateway" "tgw" {
    filter {
        name   = "tag:Name" 
        values = ["TGW-01"]
    }
}

data "aws_ec2_transit_gateway_route_table" "vpn_route_table" {
    filter {
        name   = "tag:Name" 
        values = ["VPN-Route-Table-01"]
    }

}
data "aws_ec2_transit_gateway_route_table" "dev_route_table" {
    filter {
        name   = "tag:Name" 
        values = ["VPCs-Route-Table-01"]
    }

}

# Attach VPCs to the Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  transit_gateway_id = data.aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.this.id
  subnet_ids         = aws_subnet.private[*].id
  tags = {
    Name =  "${var.env}-tgw-att" 
  }
  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
}

resource "aws_ec2_transit_gateway_route" "vpn_route" {
  destination_cidr_block         = var.vpc_cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.vpn_route_table.id
  blackhole = false
}

resource "aws_ec2_transit_gateway_route" "route_from_vpc_staging_to_vpc_dev" {
  destination_cidr_block         = var.vpc_cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.dev_route_table.id
}


resource "aws_ec2_transit_gateway_route_table_association" "vpc_association" {
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.this.id
  transit_gateway_route_table_id = data.aws_ec2_transit_gateway_route_table.dev_route_table.id
}
