export PS1=$'%F{3}%n@mbp %F{4}%~%F{5} %f %# '
terraform plan -var-file=secret.public.tfvars -out=test.plan
terraform apply -var-file=secret.public.tfvars test.plan
terraform destroy -var-file=secret.public.tfvars -target vkcs_compute_instance.tf-ubuntu-autodeploy
terraform destroy -var-file=secret.public.tfvars
