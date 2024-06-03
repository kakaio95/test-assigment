variable "db_username" {
  description = "DB user login"
  type = string
  sensitive = true
}

variable "db_password" {
  description = "DB password login"
  type = string
  sensitive = true
}

variable "private_subnets_ids" {
  type = list(string)
  description = "reference output private_subnets_ids"
}

variable "sec_group_rds_ids" {
  type = string
}