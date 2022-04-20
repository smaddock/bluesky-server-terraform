variable "do_token" {
  description = "DigitalOcean Personal Access Token from https://cloud.digitalocean.com/account/api/tokens"
  nullable    = false
  sensitive   = true
  type        = string
}
variable "domain_name" {
  description = "Domain name that points to `var.public_ip`"
  nullable    = false
  type        = string
}
variable "droplet_image" {
  default     = "debian-11-x64"
  description = "ID or slug identifier of the base image for the Droplet"
  nullable    = false
  type        = any
}
variable "droplet_size" {
  default     = "s-1vcpu-1gb"
  description = "Slug identifier of the DigitalOcean Droplet size"
  nullable    = false
  type        = string
}
variable "droplet_tags" {
  default     = []
  description = "List of DigitalOcean tags to be applied to the Droplet"
  type        = list(string)
}
variable "enable_firewall" {
  default     = true
  description = "Configure a DigitalOcean Firewall in front of the Droplet"
  type        = bool
}
variable "public_ip" {
  description = "IP address of an **existing** DigitalOcean Floating IP"
  nullable    = false
  type        = string
}
variable "region" {
  description = "Slug identifier of the DigitalOcean data center region, e.g., sfo1"
  nullable    = false
  type        = string
}
variable "timezone" {
  description = "Linux server time zone, e.g., America/Los_Angeles"
  nullable    = false
  type        = string
}
