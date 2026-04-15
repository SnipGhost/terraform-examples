# All expressions from lecture

```tf
2 + 2
2 - 2
2 * 2
2 / 2
2 % 2
2 > 2
2 < 2
2 <= 2
true && "true"
true && false
true || false
"true" == "true"
"true" != "true"
!true
abs(-8.8)
floor(8.8)
ceil(8.1)
log(16, 2)
min(16, 2)
max(16, 2)
pow(2, 10)
parseint("FF", 16)
parseint("-10", 10)
parseint("1010101001", 2)
parseint("3", 2)
signum(-3)
signum(0)
signum(3)
chomp("hello\r\n\n")
chomp("hello")
format("Iteration %d from 100", 12)
formatlist("VM: %s", ["test-vm", "prod-vm"])
lower("HeLlO")
upper("HeLlO")
join(", ", ["test-vm", "prod-vm", "stage-vm"])
split(", ", "test-vm, prod-vm, stage-vm")
regex("vm-([a-z]+)-[0-9]+", "vm-test-1")
regexall("vm-([a-z]+)-[0-9]+", "vm-test-1")
replace("hello world", "/w.*d/", "everybody")
indent(2, "foo\nbar\nbaz")
strrev("1234")
substr("1234567890", 1, 4)
title("hello, world")
trim("hh_hsor_ry_hhh", "h_")
trimspace("   hall \n\n")
trimprefix("test-vm-1", "test")
alltrue(["true", true])
alltrue([true, false])
anytrue([true, false])
coalesce("", "b")
coalesce("a", "b")
chunklist(["a", "b", "c", "d", "e"], 2)
compact(["1", "", "3", "4"])
concat(["1", ""], ["3", "4"])
contains(["1", "2", "3"], "2")
distinct(["1", "2", "2", "1", "3", "1", "2"])
element(["1", "2", "3"], 0)
element(["1", "2", "3"], 1)
element(["1", "2", "3"], 3)
index(["1", "2", "3"], "2")
keys({a=1, b=2, c=3})
values({a=1, b=2, c=3})
length([1, 2, 3])
flatten([["1", "2"], ["3", []], []])
lookup({a="123", b="456"}, "a", "not_found")
lookup({a="123", b="456"}, "c", "not_found")
matchkeys(["k1", "k2", "k3"], ["v1", "v2", "v2"], ["v2"])
merge({a=1, b=2}, {c=3, b=4})
range(3)
reverse([1, 2, 3])
one([])
one([5])
one([5, 4])
setintersection([1, 2], [2, 3])
setsubtract([1, 2], [2, 3, 4])
setunion([1], [2])
setproduct([1, 2], [3, 4])
zipmap(["a", "b"], [1, 2])
sum([10, 20, 30])
min([10, 5, 12]...)
pow([10, 2]...)
transpose({"a" = [1, 2], "b" = [3, 4]})
base64encode("test")
base64decode("dGVzdA==")
jsonencode({a=1, b=2})
jsondecode("{\"a\":1,\"b\":2}")
urlencode("ho/ho")
bcrypt("test")
abspath(path.root)
dirname(“/etc/nginx/nginx.conf”)
pathexpand(“~/.ssh/id_ras”)
file(“${path.module}/filename.txt”)
fileexists(“${path.module}/filename.txt”)
templatefile(“${path.module}/filename.txt”)
formatdate("DD.MM.YYYY hh:mm:ss ZZZ", timestamp())
timestamp()
timeadd(timestamp(), "1h")
cidrhost("192.168.127.64/29", 3)
cidrnetmask("192.168.127.64/29")
cidrsubnet("192.168.0.0/16", 2, 2)
cidrsubnets("192.168.0.0/16", 2, 2, 2)
"Hello, world"
"Hello, world\n"
"Hello, ${var.env}"
"Hello %{if var.env == "test"}dev%{else}user%{endif}!"
var.env == "prod" ? "count=1" : "count=0"
[for x in var.data_list : upper(x)]
[for i, v in var.data_list : "${i} is ${v}"]
[for k, v in var.env_map : "${k} is ${v}"]
[for x in var.data_list : x if x != "world"]
{for i, v in var.data_list : i => v}
{for v in var.data_list : v => upper(v) if strcontains(v, "!")}
{for v in var.data_list : v => upper(v) if !strcontains(v, "!")}
flatten([for vm in var.vms : [for iface in vm.interfaces : iface["ip"]]])
[for x in var.data_list : x]
var.data_list[*]
[for x in var.vms : x.interfaces[0].ip]
var.vms[*].interfaces[0].ip
[for x in var.vms : upper(x.interfaces[0].name)]
# WRONG: upper(var.vms[*].interfaces[0].name)
```