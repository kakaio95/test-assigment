resource "aws_vpc" "vpc_workloads" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  
  tags = {
    Name = "vpc_workloads"
    Stack = "Terraform"
  }
}

