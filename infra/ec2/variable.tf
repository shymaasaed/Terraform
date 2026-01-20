variable "vpc_id" { type = string }
variable "public_subnet_id" { type = string }

variable "bastion_ami" { type = string }
variable "instance_type" { type = string }
variable "key_name" { type = string }
variable "allowed_ssh_cidr" { type = string }

variable "project_name" { type = string }
variable "common_tags" { type = map(string) }
variable "create_keypair" {
  type    = bool
  default = true
}

variable "keypair_name" {
  type    = string
  default = "shin-bastion-key"
}
