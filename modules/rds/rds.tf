resource "aws_db_instance" "db_workloads_001" {
  engine               =  "postgres"
  instance_class       =  "db.t3.micro"
  allocated_storage    =  20
  storage_type         =  "gp2"
  username             =  var.db_username
  password             =  var.db_password
  parameter_group_name =  "default.postgres12"
  publicly_accessible  =  false
  vpc_security_group_ids = [ aws_security_group.sec_group_rds.id ]
  db_subnet_group_name  = aws_db_subnet_group.db_subnet_group.name

  depends_on = [ db_subnet_group ]
}


resource "aws_db_subnet_group" "db_subnet_group" {
  count      =  length(var.private_subnets_ids)
  name       = "db_subnet_group"
  description = "RDS subnet group" 
  subnet_ids  = element(var.private_subnets_ids, count.index) 
}