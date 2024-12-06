# main.tf

module "aws-vpc" {
  source = "../aws-vpc"
  # Inclua outras variáveis necessárias para o módulo VPC aqui
}

# Check for existing DB subnet group
data "aws_db_subnet_group" "existing_rds_subnet_group" {
  name = "rds-postgres-dev-nvirginia-ezfastfood-subnet-group"
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  count      = data.aws_db_subnet_group.existing_rds_subnet_group.id != "" ? 0 : 1
  name       = "rds-postgres-dev-nvirginia-ezfastfood-subnet-group"
  subnet_ids = [module.aws-vpc.public_subnet_id_1, module.aws-vpc.public_subnet_id_2]  # Reference the correct subnet ID

  tags = {
    Name       = "rds-postgres-dev-nvirginia-ezfastfood-subnet-group"
    Environment = "dev"
    Project    = "ez-fast-food"
  }
}

# RDS PostgreSQL Database Instance
resource "aws_db_instance" "postgresql" {
  identifier            = "rds-postgres-dev-nvirginia-ezfastfood"
  allocated_storage     = 20                        # Minimum storage to fit free tier
  storage_type          = "gp2"                     # General-purpose SSD, suitable for free tier
  engine                = "postgres"                # Database engine
  engine_version        = "13.17"                   # Version eligible for free tier
  instance_class        = "db.t4g.micro"            # Free tier instance class
  username              = "postgres"                # Admin username
  password              = "postgres"                # Admin password (consider using environment variables for sensitive data)
  parameter_group_name  = "default.postgres13"      # Default parameter group for PostgreSQL 13

  publicly_accessible   = true                      # Set to false to avoid public access costs
  vpc_security_group_ids = [module.aws-vpc.rds_security_group_id]
  skip_final_snapshot   = true                      # Skips final snapshot to avoid storage costs on delete
  db_subnet_group_name  = coalesce(data.aws_db_subnet_group.existing_rds_subnet_group.name, aws_db_subnet_group.rds_subnet_group[0].name)
  
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
