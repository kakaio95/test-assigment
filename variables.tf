variable "aws_region" {
  description = "Region where going deploy"
  type = string
  default = "us-east-1"
}

variable "access_key" {
    description = "access_key for autenticate on AWS account"
    type = string
    sensitive = true
    default = "ASIAWU3QPBS7HUF5EQWL"
   # "##ACCESS_KEY##" ###switch for value access key - colocar como variavel sensivel no github
  
}

variable "secret_key" {
  description = "session_key for autenticate on AWS account" ### switch for value session_key - colocar como variavel sensivle no gihub
  type = string
  sensitive = true
  default = "JAKMMh/MAZHTie4f/28o/YUBNj5gjB+x0TGzkmEJ"
}

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