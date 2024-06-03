##### Definir o cluster EKS ######
#### CREATE ROLE TO EKS CLUSTER #########
resource "aws_iam_role" "role_eks_cluster" {
  name = "role_eks_cluster"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
         Action = "sts:AssumeRole",
         Effect = "Allow",
         Principal = {
            Service = "eks.amazonaws.com"
         }
      }
    ]
  })
}

###### ATTACHEMENT THE POLICIES AT ROLE #########
resource "aws_iam_role_policy_attachment" "role_eks_cluster_AmazoEKSClusterPolicy" {
 # name = "AmazonEKSClusterPolicy"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role      = aws_iam_role.role_eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_role_AmazonEKSVPCResourceController" {
  #name = "AmazonEKSVPCResourceController"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.role_eks_cluster.name
}







resource "aws_eks_cluster" "eks_cluster_workloads_001" {
  name     = "eks_cluster_workloads_001"
  role_arn = aws_iam_role.role_eks_cluster.arn

  vpc_config {
    subnet_ids = var.private_subnets_ids
    security_group_ids = [ var.sec_group_eks_cluster_ids ]
  }


depends_on = [
    aws_iam_role_policy_attachement.eks_cluster_role_AmazoEKSClusterPolicy,
    aws_iam_role_policy_attachement.eks_cluster_role_AmazonEKSVPCResourceController
]
}

