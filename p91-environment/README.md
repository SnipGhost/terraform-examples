# Exmaple project

## Init

```bash
cd envs/dev
terraform init -backend-config backend.hcl

cd envs/prod
terraform init -backend-config backend.hcl
```

## Tests

```bash
cd modules/compute
terraform init # local tfstate
terraform test -var-file="tests/secret.auto.tfvars"
```
