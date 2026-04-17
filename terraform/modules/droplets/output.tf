output "droplet_ip" {
  value       = digitalocean_droplet.this.ipv4_address
  description = "Public IP address of the droplet"
  sensitive   = true
}

output "droplet_id" {
  value       = digitalocean_droplet.this.id
  description = "ID of the droplet"
}

output "droplet_name" {
  value       = digitalocean_droplet.this.name
  description = "Name of the droplet"
}

output "droplet_private_key" {
  value       = tls_private_key.deploy_key.private_key_openssh
  description = "Private SSH key"
}
