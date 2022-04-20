# Base requirements for Terraform and DigitalOcean TF provider

provider "digitalocean" {
  token = var.do_token
}

terraform {
  required_providers {
    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = ">= 2.2.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.19"
    }
  }
  required_version = ">= 1.1.8"
}
