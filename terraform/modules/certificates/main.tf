resource "tls_private_key" "origin_key_ecc" {
  for_each    = { for c in var.certs : c.hostname => c }
  algorithm   = "ECDSA"
  ecdsa_curve = "P256"
}

resource "tls_cert_request" "origin_csr_ecc" {
  for_each        = { for c in var.certs : c.hostname => c }
  private_key_pem = tls_private_key.origin_key_ecc[each.key].private_key_pem

  subject {
    common_name  = each.value.hostname
    organization = "quantinium"
  }
}

resource "cloudflare_origin_ca_certificate" "this" {
  for_each           = { for c in var.certs : c.hostname => c }
  csr                = tls_cert_request.origin_csr_ecc[each.key].cert_request_pem
  hostnames          = [each.value.hostname]
  request_type       = "origin-ecc"
  requested_validity = each.value.validity
}

resource "terraform_data" "upload_certs" {
  for_each = { for c in var.certs : c.hostname => c }

  input = {
    cert_id   = cloudflare_origin_ca_certificate.this[each.key].id
    server_id = each.value.server_id
  }

  connection {
    type        = "ssh"
    user        = each.value.server_user
    host        = each.value.server_host
    private_key = each.value.server_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "set -e", # Exit on any error
      "sudo mkdir -p /etc/nginx/certificates",
      "echo '${cloudflare_origin_ca_certificate.this[each.key].certificate}' | sudo tee /etc/nginx/certificates/${each.value.hostname}.pem > /dev/null",
      "echo '${tls_private_key.origin_key_ecc[each.key].private_key_pem}' | sudo tee /etc/nginx/certificates/${each.value.hostname}.key > /dev/null",
      "sudo chmod 644 /etc/nginx/certificates/${each.value.hostname}.pem",
      "sudo chmod 600 /etc/nginx/certificates/${each.value.hostname}.key",
      "sudo chown root:root /etc/nginx/certificates/${each.value.hostname}.*",
      "if systemctl is-active --quiet nginx; then sudo systemctl reload nginx; fi"

    ]
  }
}
