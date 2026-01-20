output "bucket_arn" {
  value = try(aws_s3_bucket.this[0].arn, null)
}
