resource "aws_iam_user" "iam_users" {
  count = length(var.usernames)
  name  = replace(var.usernames[count.index], " ", "_")
}

resource "aws_iam_access_key" "credentials" {
  count = length(aws_iam_user.iam_users[*].name)
  user  = aws_iam_user.iam_users[count.index].name
}

resource "aws_iam_user_login_profile" "credentials" {
  count                   = length(aws_iam_user.iam_users[*].name)
  user                    = aws_iam_user.iam_users[count.index].name
  password_reset_required = true
}

resource "aws_iam_user_policy" "ec2_policy" {
  count = length(aws_iam_user.iam_users[*].name)
  name  = "${var.policy_name}_${aws_iam_user.iam_users[count.index].name}"
  user  = aws_iam_user.iam_users[count.index].name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Action" : [
          "ec2:*",
          "iam:ChangePassword"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "aws-portal:ViewBilling",
          "aws-portal:ViewPaymentMethods",
          "aws-portal:ViewUsage",
          "aws-portal:ViewAccount",
          "ce:*",                // Quyền truy cập Cost Explorer
          "aws-portal:ViewCosts" // Quyền truy cập vào trang AWS Billing
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "organizations:DescribeOrganization"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "s3:GetBucketTagging",
          "s3:PutBucketTagging",
          "s3:GetBucketPolicy",
          "s3:PutBucketPolicy",
          "s3:ListBucket",
          "s3:CreateBucket"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:s3:::aws-map-cur-bucket-*"
      },
      {
        "Action" : [
          "cur:PutReportDefinition",
          "cur:DeleteReportDefinition",
          "cur:DescribeReportDefinitions"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:cur:*:*:definition/map-migrated-report"
      },
      {
        "Action" : "cur:DescribeReportDefinitions",
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Sid" : "AllowAWSServiceAccessForCostOptimizationHub",
        "Effect" : "Allow",
        "Action" : [
          "organizations:EnableAWSServiceAccess"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringLike" : {
            "organizations:ServicePrincipal" : [
              "cost-optimization-hub.bcm.amazonaws.com"
            ]
          }
        }
      },
    ]
  })


}
