module "droplets" {
  source = "./modules/droplets"

  droplet_name    = "citadel"
  droplet_user    = var.droplet_user
  deploy_key_name = "citadel-key"
  droplet_image   = "ubuntu-24-04-x64"
  droplet_size    = "s-2vcpu-2gb"
  droplet_region  = "blr1"
  tags            = ["citadel"]
}

module "dns" {
  source = "./modules/dns"

  domain = var.domain

  records = [
    { name = "citadel", value = module.droplets.droplet_ip, type = "A", proxied = true, ttl = 1 },
    { name = "uptime-citadel", value = module.droplets.droplet_ip, type = "A", proxied = true, ttl = 1 }
  ]
}

module "certificates" {
  source     = "./modules/certificates"
  depends_on = [module.droplets.droplet_ip]
  certs = [
    {
      hostname           = "citadel.${var.domain}"
      validity           = 5475
      server_id          = "${module.droplets.droplet_id}"
      server_host        = "${module.droplets.droplet_ip}"
      server_user        = "${var.droplet_user}"
      server_private_key = module.droplets.droplet_private_key
    },
    {
      hostname           = "uptime-citadel.${var.domain}"
      server_id          = "${module.droplets.droplet_id}"
      validity           = 5475
      server_host        = "${module.droplets.droplet_ip}"
      server_user        = "${var.droplet_user}"
      server_private_key = module.droplets.droplet_private_key
    }
  ]
}
