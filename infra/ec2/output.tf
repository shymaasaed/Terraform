output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "bastion_instance_id" {
  value = aws_instance.bastion.id
}
output "bastion_keypair_name" {
  value = var.create_keypair ? aws_key_pair.bastion[0].key_name : null
}

output "bastion_keypair_pem_path" {
  value = var.create_keypair ? "${path.module}/${var.keypair_name}.pem" : null
}
