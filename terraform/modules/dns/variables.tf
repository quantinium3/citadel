variable "domain" {
  type        = string
  description = "Domain for which records must be added"
}

variable "records" {
  description = "List of DNS records to create"
  type = list(object({
    name    = string
    value   = string
    ttl     = number
    type    = string
    proxied = optional(bool, true)
  }))
}
