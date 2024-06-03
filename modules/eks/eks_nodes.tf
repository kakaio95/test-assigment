resource "aws_eks_node_group" "eks_node_group_workloads_001" {
  cluster_name    = aws_eks_cluster.eks_cluster_workloads_001.name
  node_group_name = "eks_node_group_workloads_001"
  node_role_arn   = aws_iam_role.role_eks_node_group.arn
  subnet_ids      = var.private_subnets_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t3.medium"]

  depends_on = [
    aws_launch_template.eks_nodes,
    aws_iam_role_policy_attachment.eks_nodes_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks_nodes_AmazonEC2ContainerRegistryReadOnly,
    aws_iam_role_policy_attachment.eks_nodes_AmazonEKS_CNI_Policy
  ]
}

resource "aws_iam_role" "role_eks_node_group" {
  name = "role_eks_node_group"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_nodes_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.role_eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_nodes_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.role_eks_node_group.name
}

resource "aws_iam_role_policy_attachment" "eks_nodes_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.role_eks_node_group.name
}

resource "aws_launch_template" "eks_nodes" {
  name_prefix   = "eks_nodes_"
  image_id      = data.aws_ami.eks_worker.id
  instance_type = "t3.medium"
  key_name      = "key_pair_eks_node" # Add your key name

  iam_instance_profile {
    name = aws_iam_instance_profile.eks_nodes.name
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [module.vpc.sec_group_eks_node.id]
  }

  user_data = base64encode(data.template_file.eks_node_bootstrap.rendered)
}

resource "aws_iam_instance_profile" "eks_nodes" {
  name = "eks_nodes"

  role = aws_iam_role.role_eks_node_group.name
}

data "aws_ami" "eks_worker" {
  most_recent = true
  owners      = ["602401143452"] # EKS AMI owner ID

  filter {
    name   = "name"
    values = ["amazon-eks-node-1.20-*"] # Update this based on your EKS version
  }
}

data "template_file" "eks_node_bootstrap" {
  template = file("${path.module}/eks_node_bootstrap.sh")

  vars = {
    cluster_name = aws_eks_cluster.eks_cluster_workloads_001.name
  }
}
