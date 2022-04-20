# Data from providers used when provisioning resources

# Combines multiple cloud-init user-data files into a multipart MIME
data "cloudinit_config" "bluesky" {
  base64_encode = false
  gzip          = false
  part {
    content = templatefile("../templates/cloud-config.tftpl", {
      DOMAIN   = "${var.domain_name}"
      TIMEZONE = "${var.timezone}"
    })
    content_type = "text/cloud-config"
    filename     = "cloud-config.yml"
  }
  part {
    content      = file("../templates/cloud-init.sh")
    content_type = "text/x-shellscript"
    filename     = "cloud-init.sh"
  }
}

# References existing DigitalOcean Floating IP based on provided IP address
data "digitalocean_floating_ip" "bluesky" {
  ip_address = var.public_ip
}

# References all SSH keys in the DigitalOcean account
data "digitalocean_ssh_keys" "account-keys" {}
