variable "certs" {
  description = "List of origin certs to create"
  type = list(object({
    hostname           = string
    validity           = number
    server_host        = string
    server_user        = string
    server_id          = string
    server_private_key = string
  }))
}
