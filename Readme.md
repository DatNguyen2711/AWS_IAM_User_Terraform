## Create IAM User with Terraform

![image](https://github.com/DatNguyen2711/AWS_IAM_User_Terraform/assets/81822483/6d4de583-4b8a-4704-9988-0f5d87f996bc)

## Run this command to create and attach policies for IAM User

```bash

terraform init

terraform apply --auto-approve

terraform apply

```

To show your password and key, run these commands

```bash

terraform output --raw user_password


terraform output --raw secret_key


```
