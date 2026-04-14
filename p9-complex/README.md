# Exmaple project

## Init

```bash
terraform init -backend-config backend.hcl

terraform workspace new prod
terraform workspace list
terraform workspace select default
terraform workspace list

terraform plan -var-file=$(terraform workspace show).tfvars
terraform apply -var-file=$(terraform workspace show).tfvars
```
