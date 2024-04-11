output "username" {
  value = module.IAM.usernames
}

output "user_arns" {
  value = module.IAM.user_arns
}

output "secret_keys" {
  value     = module.IAM.secrets
  sensitive = true
}

output "access_keys" {
  value = module.IAM.access_keys
}

output "user_passwords" {
  value     = module.IAM.passwords
  sensitive = true
}

output "user_ids" {
  value = module.IAM.user_ids

}
