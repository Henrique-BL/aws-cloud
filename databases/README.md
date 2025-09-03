## Databases

This service is responsible for defining an RDS Postgres instance with VPC and EC2 connections.

### Structure 

/databases/vpc: public, private and database subnets IP ranges and CIDR blocks.
/databases/ec2: EC2 instance inside the VPC.
/databases/rds: RDS instance inside the VPC.

**Note**: The key aspect is that all resources are inside a VPC with security group ingress and egress rules. Internet connections can occur through the EC2 instance, with an SSH tunnel for example, or from inside the machine.