output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = module.subnet.public_subnet_id
}

output "private_subnet_ids" {
  value = module.subnet.private_subnet_ids
}

output "igw_id" {
  value = module.igw.igw_id
}

output "nat_gateway_id" {
  value = module.ngw.nat_gw_id
}

output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}

output "iam_group" {
  value = module.iam.group_name
}

output "iam_users" {
  value = module.iam.users
}
