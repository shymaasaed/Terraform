resource "aws_iam_group" "this" {
  name = var.group_name
}

resource "aws_iam_user" "users" {
  for_each = toset(var.users)
  name     = each.value

  tags = merge(var.common_tags, {
    Name = "${var.project_name}-${each.value}"
  })
}

resource "aws_iam_user_group_membership" "membership" {
  for_each = toset(var.users)

  user   = aws_iam_user.users[each.value].name
  groups = [aws_iam_group.this.name]
}

# ONE policy doc includes all services permissions
data "aws_iam_policy_document" "dev_policy" {

  # S3 RW
  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject"
    ]
    resources = var.s3_bucket_arn == "*" ? ["*"] : [
      var.s3_bucket_arn,
      "${var.s3_bucket_arn}/*"
    ]
  }

  # EC2 RW (limited)
  statement {
    actions = [
      "ec2:RunInstances",
      "ec2:TerminateInstances",
      "ec2:StartInstances",
      "ec2:StopInstances",
      "ec2:RebootInstances",
      "ec2:ModifyInstanceAttribute"
    ]
    resources = ["*"]
  }


  # EC2 RO
  statement {
    actions = [
      "ec2:Describe*",
      "ec2:Get*",
      "ec2:List*"
    ]
    resources = ["*"]
  }

  # EKS RW
  statement {
    actions = [
      "eks:DescribeCluster",
      "eks:DescribeNodegroup",
      "eks:ListClusters",
      "eks:ListNodegroups",
      "eks:UpdateClusterVersion",
      "eks:UpdateNodegroupVersion"
    ]
    resources = ["*"]
  }

  # DynamoDB RW
  statement {
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem"
    ]
    resources = ["*"]
  }

  # RDS RW (limited)
  statement {
    actions = [
      "rds:DescribeDBInstances",
      "rds:DescribeDBClusters",
      "rds:ModifyDBInstance",
      "rds:ModifyDBCluster",
      "rds:StartDBInstance",
      "rds:StopDBInstance"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "developers" {
  name   = "${var.project_name}-${var.group_name}-policy"
  policy = data.aws_iam_policy_document.dev_policy.json
}

resource "aws_iam_group_policy_attachment" "attach" {
  group      = aws_iam_group.this.name
  policy_arn = aws_iam_policy.developers.arn
}
