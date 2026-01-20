output "group_name" {
  value = aws_iam_group.this.name
}

output "users" {
  value = [for u in aws_iam_user.users : u.name]
}

output "policy_arn" {
  value = aws_iam_policy.developers.arn
}
