# Terraform project
## 1-Terraform S3 Backend with DynamoDB State Lock
This guide provides step-by-step instructions to set up an S3 backend with DynamoDB state locking for Terraform. This setup ensures that your Terraform state is stored securely and prevents concurrent modifications .
## Prerequisites
- AWS Account
- AWS CLI installed
- Terraform installed

## AWS CLI Configuration

```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Enter default region (e.g., <aws-region>)
# Enter default output format (json)
```

## Create IAM User for Terraform

```bash
# Create user
aws iam create-user --user-name <terraform-user-name>

# Create access key
aws iam create-access-key --user-name <terraform-user-name>
```

## Attach Policy to User

```bash
aws iam attach-user-policy --user-name <terraform-user-name> \
    --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
```

## Create S3 Bucket for State

```bash
aws s3api create-bucket --bucket <s3-bucket-name> --region <aws-region>
aws s3api put-bucket-versioning --bucket <s3-bucket-name> \
    --versioning-configuration Status=Enabled
```

## Create DynamoDB Table for Locking

```bash
aws dynamodb create-table --table-name <dynamodb-table-name> \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```

## Configure Terraform Backend

Create `backend.tf`:

```hcl
terraform {
    backend "s3" {

        bucket         = "<s3-bucket-name>"
        key            = "<terraform-state-key>"
        region         = "<aws-region>"
        dynamodb_table = "<dynamodb-table-name>"
        encrypt        = true
    }
}
```

## Initialize Terraform

```bash
terraform init
terraform plan
terraform apply
```
# 2- Create High Available infra using Terraform custom  Modules 
 to create a vpc , 1 public subnet , 2 private subnets 
 1 internet gateway , 1 nat gateway , route tables ,ec2 instance in public subnet to work as bastion host with pem key 
 Group Users and Attach Group Policy with limitation to Read & write on [Ec2,Rds,s3,EKS,dynmo]
Root directory tree
```
.
├── README.md
├── backend.tf
├── ec2
│   ├── main.tf
│   ├── output.tf
│   ├── sheen-bastion-key.pem
│   └── variable.tf
├── iam
│   ├── main.tf
│   ├── output.tf
│   └── variable.tf
├── igw
│   ├── main.tf
│   ├── output.tf
│   └── variable.tf
├── main.tf
├── ngw
│   ├── main.tf
│   ├── output.tf
│   └── variable.tf
├── output.tf
├── provider.tf
├── rt
│   ├── main.tf
│   ├── output.tf
│   └── variable.tf
├── s3
│   ├── main.tf
│   ├── output.tf
│   └── variable.tf
├── subnet
│   ├── main.tf
│   ├── output.tf
│   └── variable.tf
├── terraform.tfvars
├── variable.tf
└── vpc
    ├── main.tf
    ├── output.tf
    └── variable.tf

9 directories, 33 files
```

## Initialize AWS infra 

```bash
terraform init
terraform plan
terraform apply
#to navigate outputs you can redirect the output 
terraform output >terraform-output
#after finishing you will find a pem key inside ec2 directory to ssh bstion host 
chmod 400 path/key.pem
ssh -i path/key.pem ec2-user@public-ip 
```

## Notes
- If you configured Backend before , use <terraform init -reconfigure>
- Remember to replace placeholders (e.g., `<s3-bucket-name>`, `<aws-region>`) with actual values.
- add vars to terraform copy.tfvars because its empty file and move it to terraform.tfvars


## AWS Gallery

# Resource Map of VPC
![Resource Map of VPC](infra/images/resourcemap.png)
# Developers Setup
![Developers Setup](infra/images/develpers.png)
# IAM Policies and Roles
![IAM Policies](infra/images/polcies.png)
# Bastion Host SSH Connection
![Bastion SSH connection](infra/images/bastion.png)
# Terraform Output
![Output Screenshot](infra/images/output.png)
# Infrastructure Graph
![infra grahp](infra/images/graph.svg) 




