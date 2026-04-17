variable "droplet_name" {
  type        = string
  description = "Name of the droplet"
}

variable "deploy_key_name" {
  type        = string
  description = "Name for the SSH key (file will be saved as ~/.ssh/{this_name})"
}

variable "droplet_region" {
  type        = string
  description = "Region for the droplet"
  default     = "blr1"
}

variable "droplet_size" {
  type        = string
  description = "Size of the droplet"
}

variable "droplet_image" {
  type        = string
  description = "Image for the droplet"
  default     = "ubuntu-24-04-x64"
}

variable "droplet_user" {
  type        = string
  description = "User of droplet"
}

variable "tags" {
  type        = list(string)
  description = "Tags for the droplet"
  default     = []
}
