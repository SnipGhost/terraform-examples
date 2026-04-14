# Terraform expressions

## Just vars and templating
```tf
"Hello, world"

"Hello, world\n"

"Hello, ${var.env}"

"Hello %{if var.env == "test"}dev%{else}user%{endif}!"
```

## Conditional
```tf
var.env == "prod" ? "count=1" : "count=0"
```

## Collections
```tf
[for x in var.data_list : upper(x)]

[for i, v in var.data_list : "${i} is ${v}"]

[for k, v in var.env_map : "${k} is ${v}"]

[for x in var.data_list : x if x != "world"]

{for i, v in var.data_list : i => v}

{for v in var.data_list : v => upper(v) if contains(v, "!")}

flatten([for vm in var.vms : [for iface in vm.interfaces : iface["ip"]]])
```

## Splat
```
[for x in var.data_list : x]
var.data_list[*]

[for x in var.vms : x.interfaces[0].ip]
var.vms[*].interfaces[0].ip

[for x in var.vms : upper(x.interfaces[0].name)]
# WRONG:
upper(var.vms[*].interfaces[0].name)
```


## Debug
```bash
export TF_LOG=TRACE
export TF_LOG_CORE=DEBUG
export TF_LOG_PROVIDER=INFO
export TF_LOG_PATH=./terraform.log
terraform plan
```


## S3 Backend

```bash
export AWS_ACCESS_KEY_ID="..."
export AWS_SECRET_ACCESS_KEY="..."

# Move state file to new backend
terraform init -migrate-state

# Or just reconfigure
terraform init -reconfigure
```


## Working with S3

```bash
brew install awscli
aws configure
```

Fill values:
```bash
AWS Access Key ID [None]: ...
AWS Secret Access Key [None]: ...
Default region name [None]: ru-msk
Default output format [None]: json
```

Check encryption:
```bash
alias aws3api="aws s3api --endpoint-url https://hb.ru-msk.vkcloud-storage.ru"

bucket="mcs0411372075"

# Upload file test.txt to bucket root
aws3api put-object \
  --bucket $bucket \
  --key test.txt \
  --body test.txt \
  --server-side-encryption AES256

# Check object metadata for SSE
aws3api head-object --bucket $bucket --key test.txt
```
