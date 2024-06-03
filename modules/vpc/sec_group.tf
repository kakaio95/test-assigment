resource "aws_security_group" "sec_group_eks_cluster" {
  name        = "sec_group_eks"
  description = "Security group for EKS"
  vpc_id      =  aws_vpc.vpc_workloads.id


##### RULES EGRESS CLUSTER EKS#######

egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1" #ALL PRTOOCOLS
  cidr_blocks = ["0.0.0.0/0"]
  
}

tags = {
    Name = "sec_group_eks_cluster"
    Stack = "Terraform"
 }

###### RULES INGRESS CLUSTER EKS ######

ingress {
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
 }
}

resource "aws_security_group" "sec_group_eks_node" {
  
######## RULES INGRESS NODE EKS ######

ingress {
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [aws_vpc.vpc_workloads.cidr_block]
}

######## RULES ENGRESS NODE EKS #######

egress {
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = [ "0.0.0.0/0" ]
}

tags = {
    Name = "sec_group_eks_node"
    Stack = "Terraform"
 }
}

resource "aws_security_group" "sec_group_rds" {
  name        = "sec_group_rds" 
  description = "Security group for the RDS instance"
  vpc_id      = aws_vpc.vpc_workloads.id

ingress {
  from_port = 5432
  to_port   = 5432
  protocol  = "tcp"
  cidr_blocks = [ aws_vpc.vpc_workloads.cidr_block ]
 }

egress  {
   from_port = 0
   to_port   = 0
   protocol  = "-1"
   cidr_blocks = ["0.0.0.0/0"]
}

tags = {
  Name = "sec_group_rds"
  Stack = "Terraform"
}
}

resource "aws_security_group" "sec_group_alb" {
  name        = "sec_group_alb" 
  description = "Security group for the ALB"
  vpc_id      = aws_vpc.vpc_workloads.id


ingress {
  from_port = 80
  to_port   = 80
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

}

ingress {
  from_port = 443
  to_port   = 443
  protocol  = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

tags = {
    Name = "sec_group_alb"
    Stack = "Terraform"
 }
}