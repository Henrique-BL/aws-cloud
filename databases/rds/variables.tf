variable "ec2_key_name" {
  description = "Name of the AWS key pair for EC2 instance"
  type        = string
  default     = ""
}
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["sa-east-1a", "sa-east-1c"]
}

# RDS Configuration Variables
variable "db_identifier" {
  description = "The name of the RDS instance"
  type        = string
  default     = "postgres-example-db"
}

variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
  default     = "aws_cloud_studies_db"
}

variable "db_username" {
  description = "Username for the master DB user"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "The allocated storage in gigabytes"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "The upper limit to which Amazon RDS can automatically scale the storage of the DB instance"
  type        = number
  default     = 20
}

variable "db_engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "16.4"
}

variable "db_backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created"
  type        = string
  default     = "03:00-04:00"
}

variable "db_maintenance_window" {
  description = "The window to perform maintenance in"
  type        = string
  default     = "sun:04:00-sun:05:00"
}

variable "db_deletion_protection" {
  description = "The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Determines whether a final DB snapshot is created before the DB instance is deleted"
  type        = bool
  default     = true
}

# Common Tags
variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "rds-postgres"
    Terraform   = "true"
  }
}

# VPC-related variables passed from root module
variable "vpc_id" {
  description = "ID of the VPC where resources will be created"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  type        = string
}

variable "database_subnet_group_name" {
  description = "Name of the database subnet group"
  type        = string
}

variable "rds_security_group_id" {
  description = "ID of the RDS security group from VPC module"
  type        = string
}