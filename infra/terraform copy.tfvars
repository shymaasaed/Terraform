aws_region   = ""
project_name = ""

common_tags = {
  Owner   = ""
  Project = ""
}

vpc_cidr = ""

availability_zones   = ["", ""]
public_subnet_cidr   = ""
private_subnet_cidrs = ["", ""]

bastion_ami           = " "
bastion_instance_type = ""
bastion_key_name      = ""

allowed_ssh_cidr = ""

iam_group_name = " "
iam_users      = ["1", "2", "3", "4", "5", "6"]

# optional:
s3_bucket_arn  = "*"
create_keypair = true
keypair_name   = " "
