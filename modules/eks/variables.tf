variable "private_subnets_ids" {
  type = list(string)
  description = "reference output private_subnets_ids module vpc"
}

variable "sec_group_eks_cluster_ids" {
  type = string
  description = "reference output sec_group_eks_cluster_ids module vpc"
}