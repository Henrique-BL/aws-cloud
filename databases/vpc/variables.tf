variable "availability_zones" {
  description = "The availability zones to use for the VPC"
  type        = list(string)
  default     = ["sa-east-1a", "sa-east-1b"]
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The name for the VPC"
  type        = string
  default     = "aws-cloud-studies-vpc"
}

variable "vpc_tags" {
  description = "The tags for the VPC"
  type        = map(string)
  default = {
    "Name" = "aws-cloud-studies-vpc"
  }
}