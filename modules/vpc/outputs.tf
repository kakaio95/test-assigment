####### VPC #######

output "vpc_id" {
  value = aws_vpc.vpc_workloads.id
}

###### SUBNETS #######

output "public_subnets_workloads_id" {
    value = aws_subnet.public_subnets_workloads[*].id
  
}

output "private_subnets_workloads_id" {
    value = aws_subnet.private_subnets_workloads[*].id
}

######### INTERNET_GW ##########

output "internet_gateway_id" {
  value = aws_internet_gateway.igw_workloads.id
}

######### SECURITY GROUPS ###########

output "sec_group_eks_cluster_id" {
  value = aws_security_group.sec_group_eks_cluster.id
}

output "sec_group_eks_node_id" {
  value = aws_security_group.sec_group_eks_node.id
}

output "sec_group_alb_id" {
  value = aws_security_group.sec_group_alb.id
}

output "sec_group_rds_id" {
  value = aws_security_group.sec_group_rds.id
}



############## ROUTE_TABLE ###########

