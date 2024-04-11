variable "usernames" {
  type    = list(string)
  default = ["datlaid", "trung nb", "kiennv", "toankt"]
}


variable "policy_name" {
  type    = string
  default = "default_policy_name"
}


variable "access_key" {
  type = string

}
variable "secret_key" {
  type = string

}
