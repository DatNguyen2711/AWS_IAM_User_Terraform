output "usernames" {
  value = aws_iam_user_login_profile.credentials[*].user
}

output "user_arns" {
  value = aws_iam_user.iam_users[*].arn
}
output "user_ids" {
  value = aws_iam_user.iam_users[*].unique_id
}
output "passwords" {
  value     = aws_iam_user_login_profile.credentials[*].password
  sensitive = true
}

output "access_keys" {
  value = aws_iam_access_key.credentials[*].id
}

output "secrets" {
  value     = aws_iam_access_key.credentials[*].secret
  sensitive = true
}
