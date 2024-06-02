variable "template_name" {
  type    = string
  default = "k8sdenyrunasroot"
}

variable "constraint_name" {
  type    = string
  default = "deny-runasroot"
}

variable "rego_script" {
  type    = string
  default = <<-EOT
  package k8sdenyrunasroot

  violation[{"msg": msg}] {
    input.review.object.spec.containers[_].securityContext.runAsUser == 0
    msg := sprintf("Running as root is not allowed: %v", [input.review.object.spec.containers[_].name])
  }
  EOT
}