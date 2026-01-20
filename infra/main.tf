module "vpc" {
  source       = "./vpc"
  vpc_cidr     = var.vpc_cidr
  project_name = var.project_name
  common_tags  = var.common_tags
}

module "subnet" {
  source               = "./subnet"
  vpc_id               = module.vpc.vpc_id
  availability_zones   = var.availability_zones
  public_subnet_cidr   = var.public_subnet_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  project_name         = var.project_name
  common_tags          = var.common_tags
}

module "igw" {
  source       = "./igw"
  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  common_tags  = var.common_tags
}

module "ngw" {
  source           = "./ngw"
  public_subnet_id = module.subnet.public_subnet_id
  project_name     = var.project_name
  common_tags      = var.common_tags
}

module "rt" {
  source             = "./rt"
  vpc_id             = module.vpc.vpc_id
  igw_id             = module.igw.igw_id
  nat_gw_id          = module.ngw.nat_gw_id
  public_subnet_id   = module.subnet.public_subnet_id
  private_subnet_ids = module.subnet.private_subnet_ids
  project_name       = var.project_name
  common_tags        = var.common_tags
}

module "ec2" {
  source           = "./ec2"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.subnet.public_subnet_id
  bastion_ami      = var.bastion_ami
  instance_type    = var.bastion_instance_type
  create_keypair   = var.create_keypair
  keypair_name     = var.keypair_name
  allowed_ssh_cidr = var.allowed_ssh_cidr
  key_name         = var.keypair_name
  project_name     = var.project_name
  common_tags      = var.common_tags
}

module "iam" {
  source        = "./iam"
  group_name    = var.iam_group_name
  users         = var.iam_users
  s3_bucket_arn = var.s3_bucket_arn
  project_name  = var.project_name
  common_tags   = var.common_tags
}
