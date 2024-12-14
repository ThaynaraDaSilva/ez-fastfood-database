variable "vpc_name" {
  description = "Nome da VPC onde o banco será criado"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "rds_security_group_name" {
  description = "Nome do Security Group do RDS"
  type        = string
}

variable "environment" {
  description = "Ambiente (e.g., dev, staging, prod)"
  type        = string
}

variable "project" {
  description = "Nome do projeto"
  type        = string
}

variable "allocated_storage" {
  description = "Espaço em disco alocado para o banco de dados (em GB)"
  type        = number
  default     = 20
}

variable "storage_type" {
  description = "Tipo de armazenamento (e.g., gp2, io1)"
  type        = string
  default     = "gp2"
}

variable "engine" {
  description = "Engine do banco de dados (e.g., postgres, mysql)"
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  description = "Versão do banco de dados"
  type        = string
  default     = "13.17"
}

variable "instance_class" {
  description = "Tipo de instância RDS"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
}

variable "db_password" {
  description = "Senha do banco de dados"
  type        = string
  sensitive   = true
}

variable "parameter_group_name" {
  description = "Nome do grupo de parâmetros do banco de dados"
  type        = string
  default     = "default.postgres13"
}

variable "publicly_accessible" {
  description = "Determina se o banco de dados será publicamente acessível"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Pular snapshot final ao destruir o banco de dados"
  type        = bool
  default     = true
}

variable "rds_instance_name"{
  description = "Nome da instancia do banco de dados"
  type        = string
  default     = "rds-dev-ezfastfood"
}


