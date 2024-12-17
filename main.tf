# main.tf

# Buscar a VPC pelo nome
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"       # Nome da tag usada para identificar a VPC
    values = ["${var.vpc_name}-${var.environment}"]   # Nome da VPC especificado como variável
  }
}

# Buscar subnets associadas à VPC
data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:Environment"    # Tag para identificar subnets privadas
    values = [var.environment]
  }
}

# Buscar o Security Group do banco de dados pela tag
data "aws_security_group" "rds_sg" {
  filter {
    name   = "tag:Name"       # Nome da tag usada para identificar o SG
    values = ["${var.rds_security_group_name}-${var.environment}"]
  }
}

# Subnet Group para o RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds_instance_name
  subnet_ids = data.aws_subnets.private_subnets.ids

  tags = {
    Name        = var.rds_instance_name
    Environment = var.environment
    Project     = var.project
  }
}

# RDS PostgreSQL Database Instance
resource "aws_db_instance" "postgresql" {
  identifier            = var.rds_instance_name
  allocated_storage     = var.allocated_storage
  storage_type          = var.storage_type
  engine                = var.engine
  engine_version        = var.engine_version
  instance_class        = var.instance_class
  username              = var.db_username
  password              = var.db_password
  parameter_group_name  = var.parameter_group_name
  publicly_accessible   = var.publicly_accessible

  vpc_security_group_ids = [data.aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name

  skip_final_snapshot   = var.skip_final_snapshot

  tags = {
    Name        = var.rds_instance_name
    Environment = var.environment
    Project     = var.project
  }
}
