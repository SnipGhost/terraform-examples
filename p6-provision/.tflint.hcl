tflint {
  required_version = ">= 0.52"
  preset           = "recommended"
}

rule "terraform_naming_convention" {
  enabled = true
}
