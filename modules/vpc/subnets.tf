resource "aws_subnet" "public_subnets_workloads" {
  vpc_id           = aws_vpc.vpc_workloads.id
  count            = length(var.public_subnets_cidrs) #utiliza o comprimento do valor da variável para utilizar como parametro de count
  cidr_block       = element(var.public_subnets_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)

  tags = {
    Name = "public_subnets_workloads_${element(data.aws_availability_zones.available.names, count.index)}"
    Stack = "Terraform"
  }
}

resource "aws_subnet" "private_subnets_workloads" {
  vpc_id           = aws_vpc.vpc_workloads.id
  count            = length(var.private_subnets_cidrs)
  cidr_block       = element(var.private_subnets_cidrs, count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)


  tags = {
    Name = "private_subnets_workloads_${element(data.aws_availability_zones.available.names, count.index)}"
    Stack = "Terraform"
  }
}