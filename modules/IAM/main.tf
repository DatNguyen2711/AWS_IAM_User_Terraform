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
  count  = length(aws_iam_user.iam_users[*].name)
  name   = "${var.policy_name}_${aws_iam_user.iam_users[count.index].name}"
  user   = aws_iam_user.iam_users[count.index].name
  policy = file("ec2_policies.json")


}
