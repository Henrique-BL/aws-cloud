# Root module variables
variable "ec2_key_name" {
  description = "Name of the AWS key pair for EC2 instance"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Password for the master DB user"
  type        = string
  sensitive   = true
}