output "cluster_name" {
  description = "The Amazon Resource Name (ARN) of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster_workloads_001.arn
}

#output "node_role_arn" {
  
#}