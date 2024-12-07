module "aws-vpc" {
  source = "../aws-vpc"
  # Include other required variables for the VPC module here
}

# Check for existing DB subnet group
data "aws_db_subnet_group" "existing_rds_subnet_group" {
  name = "rds-postgres-dev-nvirginia-ezfastfood-subnet-group"
}

# Retrieve VPC ID from the Terraform state of the VPC module
data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../aws-vpc/terraform.tfstate"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  count      = length(data.aws_db_subnet_group.existing_rds_subnet_group.id) > 0 ? 0 : 1
  name       = "rds-postgres-dev-nvirginia-ezfastfood-subnet-group"
  subnet_ids = [
    module.aws-vpc.public_subnet_id_1,
    module.aws-vpc.public_subnet_id_2
  ]

  tags = {
    Name        = "rds-postgres-dev-nvirginia-ezfastfood-subnet-group"
    Environment = "dev"
    Project     = "ez-fast-food"
  }
}

# Use `try` for conditional logic
locals {
  rds_subnet_group_name = try(
    data.aws_db_subnet_group.existing_rds_subnet_group.name,
    aws_db_subnet_group.rds_subnet_group[0].name
  )
}

# RDS PostgreSQL Database Instance
resource "aws_db_instance" "postgresql" {
  identifier            = "rds-postgres-dev-nvirginia-ezfastfood"
  allocated_storage     = 20
  storage_type          = "gp2"
  engine                = "postgres"
  engine_version        = "13.17"
  instance_class        = "db.t4g.micro"
  username              = "postgres"
  password              = "postgres"
  parameter_group_name  = "default.postgres13"
  publicly_accessible   = true

  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.vpc_id]

  skip_final_snapshot   = true
  db_subnet_group_name  = local.rds_subnet_group_name

  tags = {
    Name        = "rds-postgres-dev-nvirginia-ezfastfood-instance"
    Environment = "dev"
    Project     = "ez-fast-food"
  }
}

# Output for RDS Endpoint
output "db_endpoint" {
  value = aws_db_instance.postgresql.endpoint
}
