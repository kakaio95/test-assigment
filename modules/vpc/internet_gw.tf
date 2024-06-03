resource "aws_internet_gateway" "igw_workloads" {
  vpc_id = aws_vpc.vpc_workloads.id

  tags = {
    Name = "igw_workloads"
    Stack = "Terraform"
  }
}


