# main.tf
provider "aws" {
  region = "us-east-1"  # North Virginia
}

# Create a VPC
resource "aws_vpc" "ez_fastfood_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name       = "vpc-dev-nvirginia-ezfastfood-vpc"
    Environment = "dev"
    Project    = "ez-fast-food"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ez_fastfood_vpc.id

  tags = {
    Name       = "vpc-dev-nvirginia-ezfastfood-igw"
    Environment = "dev"
    Project    = "ez-fast-food"
  }
}

# Create a Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.ez_fastfood_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name       = "vpc-dev-nvirginia-ezfastfood-public-subnet"
    Environment = "dev"
    Project    = "ez-fast-food"
  }
}

# Create a Route Table for the Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.ez_fastfood_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name       = "vpc-dev-nvirginia-ezfastfood-public-route-table"
    Environment = "dev"
    Project    = "ez-fast-food"
  }
}

# Associate the Route Table with the Public Subnet
resource "aws_route_table_association" "public_route_table_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Security Group to Allow External Access to PostgreSQL
resource "aws_security_group" "rds_security_group" {
  name        = "rds-dev-nvirginia-ezfastfood-sg"
  description = "Allow inbound PostgreSQL access for ez-fast-food project"
  vpc_id      = aws_vpc.ez_fastfood_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Replace with your IP address or range
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = "rds-dev-nvirginia-ezfastfood-sg"
    Environment = "dev"
    Project    = "ez-fast-food"
  }

}

output "vpc_id" {
  value = aws_vpc.ez_fastfood_vpc.id
}

output "subnet_id" {
  value = aws_subnet.public_subnet.id
}
