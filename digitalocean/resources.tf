# Project resources to be provisioned/destroyed by Terraform

# DigitalOcean Droplet managed by Terraform
resource "digitalocean_droplet" "bluesky" {
  backups    = true
  image      = var.droplet_image
  monitoring = true
  name       = var.domain_name
  region     = var.region
  size       = var.droplet_size
  ssh_keys   = data.digitalocean_ssh_keys.account-keys.ssh_keys.*.id
  tags       = var.droplet_tags
  user_data  = data.cloudinit_config.bluesky.rendered
}

# DigitalOcean Droplet managed by Terraform
resource "digitalocean_firewall" "bluesky" {
  count       = var.enable_firewall ? 1 : 0
  droplet_ids = [digitalocean_droplet.bluesky.id]
  name        = "bluesky"
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "3122"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# Assign DigitalOcean Floating IP to Droplet
resource "digitalocean_floating_ip_assignment" "bluesky" {
  droplet_id = digitalocean_droplet.bluesky.id
  ip_address = var.public_ip
}

# DigitalOcean Project to keep things tidy
resource "digitalocean_project" "bluesky" {
  description = "BlueSkyConnect macOS SSH tunnel"
  environment = "Production"
  name        = "bluesky"
  purpose     = "Operational / Developer tooling"
  resources = [
    data.digitalocean_floating_ip.bluesky.urn,
    digitalocean_droplet.bluesky.urn,
    digitalocean_firewall.bluesky[*].urn
  ]
}
