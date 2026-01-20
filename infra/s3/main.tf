resource "aws_s3_bucket" "this" {
  count  = var.create_bucket ? 1 : 0
  bucket = var.bucket_name

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-bucket"
  })
}
