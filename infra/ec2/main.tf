resource "aws_security_group" "bastion_sg" {
  name        = "${var.project_name}-bastion-sg"
  description = "Bastion security group"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-bastion-sg"
  })
}

resource "aws_instance" "bastion" {
  ami                         = var.bastion_ami
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  key_name                    = var.create_keypair ? aws_key_pair.bastion[0].key_name : null
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  associate_public_ip_address = true

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-bastion"
  })
}
resource "tls_private_key" "bastion" {
  count     = var.create_keypair ? 1 : 0
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion" {
  count      = var.create_keypair ? 1 : 0
  key_name   = var.keypair_name
  public_key = tls_private_key.bastion[0].public_key_openssh
}

resource "local_sensitive_file" "pem" {
  count           = var.create_keypair ? 1 : 0
  filename        = "${path.module}/${var.keypair_name}.pem"
  content         = tls_private_key.bastion[0].private_key_pem
  file_permission = "0400"
}
