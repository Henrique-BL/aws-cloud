variable "availability_zones" {
    description = "The availability zones to use for the VPC"
    type = list(string)
    default = [ "sa-east-1", "us-east-1" ]
}

variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_name" {
    description = "The name for the VPC"
    type = string
    default = "rds-vpc"
}

variable "vpc_tags" {
    description = "The tags for the VPC"
    type = map(string)
    default = {
        "Name" = "rds-postgres-vpc"
    }
}