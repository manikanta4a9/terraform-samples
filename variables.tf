variable "create_tls_cert" {
  type        = bool
  description = "Create ACM cert for var.aliases. Used only for prod."
}

variable "canonical_domain_name" {
  type        = string
  description = "Domain name to access "
}

variable "subject_alternative_names" {
  type        = list(string)
  description = "Domain names to access the website distributed by Cloud Front."
}

variable "environment" {
  default = "PoC"
}

variable "aliases" {
  default = null
}

variable "prefix" {
  default = null
}

variable "dns_zone_fqdn" {
  type        = string
  description = "DNS zone FQDN for artemis."
}

variable "terraform_execution_role" {
  type    = string
  default = null
}