# Root module that orchestrates VPC, EC2, and RDS
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "sa-east-1"
  profile = "default"
}


# VPC Module - Called once at root level
module "vpc" {
  source = "./vpc"
}

# EC2 Module - Receives VPC outputs as parameters
module "ec2" {
  source   = "./ec2"
  key_name = var.ec2_key_name

  # Pass VPC outputs to EC2 module
  vpc_id             = module.vpc.vpc_id
  vpc_cidr_block     = module.vpc.vpc_cidr_block
  public_subnets     = module.vpc.public_subnets
}

# RDS Module - Receives VPC outputs as parameters  
module "rds" {
  source = "./rds"
  # Pass VPC outputs to RDS module
  vpc_id                     = module.vpc.vpc_id
  vpc_cidr_block             = module.vpc.vpc_cidr_block
  database_subnet_group_name = module.vpc.database_subnet_group_name
  rds_security_group_id      = module.vpc.rds_security_group_id
  db_password                = var.db_password
  # RDS specific variables
  ec2_key_name               = var.ec2_key_name
}
