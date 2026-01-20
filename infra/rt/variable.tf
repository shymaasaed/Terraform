variable "vpc_id" { type = string }
variable "igw_id" { type = string }
variable "nat_gw_id" { type = string }

variable "public_subnet_id" { type = string }
variable "private_subnet_ids" { type = list(string) }

variable "project_name" { type = string }
variable "common_tags" { type = map(string) }
