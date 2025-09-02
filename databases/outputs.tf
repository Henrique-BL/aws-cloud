# Root module outputs

# VPC Outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

# EC2 Outputs
output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2.instance_public_ip
}

output "ec2_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = module.ec2.instance_private_ip
}

output "ec2_security_group_id" {
  description = "ID of the EC2 security group"
  value       = module.ec2.security_group_id
}

# RDS Outputs
output "rds_endpoint" {
  description = "RDS instance endpoint"
  value       = module.rds.rds_instance_endpoint
}

output "rds_port" {
  description = "RDS instance port"
  value       = module.rds.rds_instance_port
}

output "rds_database_name" {
  description = "RDS instance database name"
  value       = module.rds.rds_instance_name
}

output "rds_instance_id" {
  description = "RDS instance ID"
  value       = module.rds.rds_instance_id
}

# Connection Information
output "database_connection_info" {
  description = "Database connection information"
  value       = module.rds.database_connection_info
  sensitive   = true
}

output "ssh_connection_command" {
  description = "SSH command to connect to the EC2 instance"
  value       = var.ec2_key_name != "" ? "ssh -i ~/.ssh/${var.ec2_key_name}.pem ec2-user@${module.ec2.instance_public_ip}" : "SSH key not configured"
}

output "database_test_command" {
  description = "Command to test database connection from EC2"
  value       = module.rds.database_test_command
  sensitive   = true
}
