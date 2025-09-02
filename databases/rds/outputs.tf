# RDS Outputs
output "rds_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.postgres.id
}

output "rds_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.postgres.arn
}

output "rds_instance_endpoint" {
  description = "The RDS instance endpoint"
  value       = aws_db_instance.postgres.endpoint
}

output "rds_instance_hosted_zone_id" {
  description = "The canonical hosted zone ID of the DB instance (to be used in a Route 53 Alias record)"
  value       = aws_db_instance.postgres.hosted_zone_id
}

output "rds_instance_address" {
  description = "The hostname of the RDS instance"
  value       = aws_db_instance.postgres.address
}

output "rds_instance_port" {
  description = "The database port"
  value       = aws_db_instance.postgres.port
}

output "rds_instance_name" {
  description = "The database name"
  value       = aws_db_instance.postgres.db_name
}

output "rds_instance_username" {
  description = "The master username for the database"
  value       = aws_db_instance.postgres.username
  sensitive   = true
}

output "rds_security_group_id" {
  description = "ID of the RDS additional security group"
  value       = aws_security_group.rds_additional.id
}

# Connection Information
output "database_connection_info" {
  description = "Database connection information"
  value = {
    host     = aws_db_instance.postgres.address
    port     = aws_db_instance.postgres.port
    database = aws_db_instance.postgres.db_name
    username = aws_db_instance.postgres.username
  }
  sensitive = true
}

output "database_test_command" {
  description = "Command to test database connection from EC2"
  value       = "psql -h ${aws_db_instance.postgres.address} -p ${aws_db_instance.postgres.port} -d ${aws_db_instance.postgres.db_name} -U ${aws_db_instance.postgres.username}"
  sensitive   = true
}
