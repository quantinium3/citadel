resource "tls_private_key" "deploy_key" {
  algorithm = "ED25519"
}

resource "digitalocean_ssh_key" "deploy" {
  name       = "${var.deploy_key_name}-deploy-key"
  public_key = tls_private_key.deploy_key.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.deploy_key.private_key_openssh
  filename        = pathexpand("~/.ssh/${var.deploy_key_name}")
  file_permission = "0600"
}

resource "local_file" "public_key" {
  content         = tls_private_key.deploy_key.public_key_openssh
  filename        = pathexpand("~/.ssh/${var.deploy_key_name}.pub")
  file_permission = "0644"
}

resource "digitalocean_droplet" "this" {
  image      = var.droplet_image
  name       = var.droplet_name
  region     = var.droplet_region
  size       = var.droplet_size
  ssh_keys   = [digitalocean_ssh_key.deploy.fingerprint]
  monitoring = true

  user_data = templatefile("${path.module}/digitalocean.tftpl", {
    user    = var.droplet_user
    ssh_key = tls_private_key.deploy_key.public_key_openssh
  })
  tags = var.tags
}
