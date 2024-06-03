######## VPC #########

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

######## SUBNETS ###########
variable "public_subnets_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24"]
}


variable "private_subnets_cidrs" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default = [ "10.0.3.0/24", "10.0.4.0/24" ]
}

