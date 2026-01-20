variable "group_name" { type = string }
variable "users" { type = list(string) }

variable "s3_bucket_arn" {
  type    = string
  default = "*"
}

variable "project_name" { type = string }
variable "common_tags" { type = map(string) }
