variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_id_1" {
  description = "The ID of the first public subnet"
  type        = string
}

variable "public_subnet_id_2" {
  description = "The ID of the second public subnet"
  type        = string
}

variable "rds_security_group_id" {
  description = "The ID of the RDS security group"
  type        = string
}

variable "db_instance_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "rds-postgres-dev-nvirginia-ezfastfood"
}
