# main.tf

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-postgres-dev-nvirginia-ezfastfood-subnet-group"
  subnet_ids = [aws_subnet.public_subnet.id]  # Reference the correct subnet ID

  tags = {
    Name       = "rds-postgres-dev-nvirginia-ezfastfood-subnet-group"
    Environment = "dev"
    Project    = "ez-fast-food"
  }
}

# RDS PostgreSQL Database Instance
resource "aws_db_instance" "postgresql" {
  allocated_storage      = 20                        # Minimum storage to fit free tier
  storage_type           = "gp2"                     # General-purpose SSD, suitable for free tier
  engine                 = "postgres"                # Database engine
  engine_version         = "13.4"                    # Version eligible for free tier
  instance_class         = "db.t4g.micro"            # Free tier instance class
  db_name                = "postgres"                # Database name
  username               = "admin"                   # Admin username
  password               = "admin"         # Admin password (consider using environment variables for sensitive data)
  parameter_group_name   = "default.postgres13"      # Default parameter group for PostgreSQL 13

  publicly_accessible    = false                     # Set to false to avoid public access costs
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  skip_final_snapshot    = true                      # Skips final snapshot to avoid storage costs on delete
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  
  tags = {
    Name       = "rds-postgres-dev-nvirginia-ezfastfood-instance"
    Environment = "dev"
    Project    = "ez-fast-food"
  }
}

# Output for RDS Endpoint
output "db_endpoint" {
  value = aws_db_instance.postgresql.endpoint
}

output "db_name" {
  value = aws_db_instance.postgresql.name
}
