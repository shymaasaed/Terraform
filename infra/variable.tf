variable "aws_region" { type = string }

variable "project_name" { type = string }

variable "common_tags" {
  type    = map(string)
  default = {}
}

# VPC
variable "vpc_cidr" { type = string }

# Subnets
variable "public_subnet_cidr" { type = string }

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

# Bastion
variable "bastion_ami" { type = string }
variable "bastion_instance_type" { type = string }
variable "bastion_key_name" { type = string }

variable "allowed_ssh_cidr" {
  description = "Your public IP range to allow ssh"
  type        = string
}

# IAM
variable "iam_group_name" { type = string }

variable "iam_users" {
  type = list(string)
}

# Optional: limit policy to specific resources
variable "s3_bucket_arn" {
  type        = string
  description = "Optional S3 bucket ARN like arn:aws:s3:::mybucket"
  default     = "*"
}
variable "create_keypair" {
  type    = bool
  default = true
}

variable "keypair_name" {
  type    = string
  default = "sheen-bastion-key"
}

