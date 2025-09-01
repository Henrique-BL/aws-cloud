# VPC Module
module "vpc" {
  source = "../vpc"

  vpc_name           = var.vpc_name
  vpc_cidr_block     = var.vpc_cidr_block
  availability_zones = var.availability_zones
  vpc_tags          = var.tags
}

# EC2 Module  
module "ec2" {
  source = "../ec2"

  vpc_id                = module.vpc.vpc_id
  subnet_ids           = module.vpc.public_subnets
  instance_type        = var.ec2_instance_type
  key_name            = var.ec2_key_name
  instance_name       = "${var.vpc_name}-client"
  allowed_cidr_blocks = var.ec2_allowed_cidr_blocks
  tags                = var.tags

  depends_on = [module.vpc]
}

# RDS Instance
resource "aws_db_instance" "postgres" {
  identifier = var.db_identifier
  
  # Engine options
  engine         = "postgres"
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class
  
  # Storage
  allocated_storage     = var.db_allocated_storage
  max_allocated_storage = var.db_max_allocated_storage
  storage_type         = "gp2"
  storage_encrypted    = true
  
  # Database configuration
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
  
  # Network & Security
  db_subnet_group_name   = module.vpc.database_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds_additional.id, module.vpc.rds_security_group_id]
  publicly_accessible    = false
  
  # Backup & Maintenance
  backup_retention_period = var.db_backup_retention_period
  backup_window          = var.db_backup_window
  maintenance_window     = var.db_maintenance_window
  
  # Deletion protection
  deletion_protection   = var.db_deletion_protection
  skip_final_snapshot  = var.db_skip_final_snapshot
  final_snapshot_identifier = var.db_skip_final_snapshot ? null : "${var.db_identifier}-final-snapshot"
  
  # Performance Insights
  performance_insights_enabled = true
  performance_insights_retention_period = 7
  
  # Monitoring
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds_enhanced_monitoring.arn
  enabled_cloudwatch_logs_exports = ["postgresql"]
  
  tags = merge(var.tags, {
    Name = var.db_identifier
  })

  depends_on = [
    module.vpc,
    aws_iam_role_policy_attachment.rds_enhanced_monitoring
  ]
}

# Additional security group for RDS with EC2 access
resource "aws_security_group" "rds_additional" {
  name_prefix = "${var.db_identifier}-additional"
  description = "Additional security group for RDS PostgreSQL database"
  vpc_id      = module.vpc.vpc_id

  # Allow access from EC2 security group
  ingress {
    description     = "PostgreSQL from EC2"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [module.ec2.security_group_id]
  }

  tags = merge(var.tags, {
    Name = "${var.db_identifier}-additional-sg"
  })
}

# IAM role for RDS enhanced monitoring
resource "aws_iam_role" "rds_enhanced_monitoring" {
  name_prefix = "${var.db_identifier}-monitoring-"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  role       = aws_iam_role.rds_enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
