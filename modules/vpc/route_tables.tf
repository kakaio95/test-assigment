resource "aws_route_table" "public_route_table_workloads" {
  vpc_id = aws_vpc.vpc_workloads.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_workloads.id
  }

  tags = {
    Name = "public_route_table_workloads"
    Stack = "Terraform"
  }
}

resource "aws_route_table_association" "public_route_table_workloads_association" {
  route_table_id = aws_route_table.public_route_table_workloads.id
  count          = length(var.public_subnets_cidrs)
  subnet_id      = aws_subnet.public_subnets_workloads[count.index].id
}

resource "aws_route_table" "private_route_table_workloads" {
  vpc_id = aws_vpc.vpc_workloads.id
  
  tags = {
    Name = "private_route_table_workloads"
    Stack = "Terraform"
  }   
}

resource "aws_route_table_association" "private_route_table_workloads_association" {
  route_table_id = aws_route_table.private_route_table_workloads.id
  count          = length(var.private_subnets_cidrs)
  subnet_id      = aws_subnet.private_subnets_workloads[count.index].id

}