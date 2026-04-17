resource "cloudflare_dns_record" "this" {
  for_each = {
    for r in var.records : r.name => r
  }

  zone_id = data.cloudflare_zone.zone.id

  name    = each.value.name
  type    = each.value.type
  content = each.value.value
  ttl     = each.value.ttl
  proxied = each.value.proxied
}
