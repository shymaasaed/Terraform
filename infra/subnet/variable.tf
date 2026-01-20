variable "vpc_id" { type = string }
variable "availability_zones" { type = list(string) }
variable "public_subnet_cidr" { type = string }
variable "private_subnet_cidrs" { type = list(string) }
variable "project_name" { type = string }
variable "common_tags" { type = map(string) }
