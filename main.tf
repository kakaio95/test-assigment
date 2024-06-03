terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.42.0"
    }

  }
}

provider "aws" {
  region = "us-east-1"
  #access_key = var.access_key
  #secret_key = var.secret_key
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source = "./modules/eks"
  private_subnets_ids = module.vpc.private_subnets_workloads_id
  sec_group_eks_cluster_ids = module.vpc.sec_group_eks_cluster_id
}


module "rds" {
  source = "./modules/rds"
  private_subnets_ids = module.vpc.private_subnets_workloads_id
  sec_group_rds_ids = module.vpc.sec_group_rds_id
  db_username          = var.db_username
  db_password          = var.db_password

}