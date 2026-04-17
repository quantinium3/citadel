variable "do_token" {
  type        = string
  description = "DigitalOcean API token"
  sensitive   = true
}

variable "cf_token" {
  type        = string
  description = "Cloudflare API token"
  sensitive   = true
}

variable "domain" {
  type        = string
  description = "Domain for clouflare and tailscale"
}

variable "droplet_user" {
  type        = string
  description = "citadel server user"
}
