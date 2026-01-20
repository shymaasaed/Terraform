terraform {
  backend "s3" {
    bucket         = "terraform-sheen-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-infra-table"
  }
}