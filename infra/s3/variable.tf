variable "create_bucket" {
  type    = bool
  default = false
}

variable "bucket_name" {
  type    = string
  default = ""
}

variable "project_name" {
  type = string
}

variable "common_tags" {
  type = map(string)
}
