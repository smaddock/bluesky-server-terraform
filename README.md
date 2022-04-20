# BlueSky Server 3: Terraform Deployment

This is a _very_ early development version of the Terraform deployment of BlueSky Server 3, and should not be used for production!

## Use ([DigitalOcean](https://www.digitalocean.com/))

1. [Install Terraform](https://www.terraform.io/downloads) locally
1. Clone this repo locally
1. Fill in the values for `digitalocean/bluesky.tfvars` (see [below](#inputs) for details)
1. Export the `TF_VAR_do_token` environment variable with your DigitalOcean personal access token
1. From the `digitalocean/` directory, run:
    1. `terraform init`
    1. `terraform refresh`
    1. `terraform plan -out=bluesky.tfplan`
    1. If everything looks good, `terraform apply bluesky.tfplan`
1. Edit `/etc/bluesky/email.ini` with your SMTP info to receive notices and alerts

## To Do

- Test
- Update cloud-init.sh download to upstream repo
- Add Terraform files for other cloud providers

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.8 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | >= 2.2.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.19 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | >= 2.2.0 |
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.19 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.bluesky](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_firewall.bluesky](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |
| [digitalocean_floating_ip_assignment.bluesky](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/floating_ip_assignment) | resource |
| [digitalocean_project.bluesky](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/project) | resource |
| [cloudinit_config.bluesky](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |
| [digitalocean_floating_ip.bluesky](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/floating_ip) | data source |
| [digitalocean_ssh_keys.account-keys](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/data-sources/ssh_keys) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_do_token"></a> [do\_token](#input\_do\_token) | DigitalOcean Personal Access Token from https://cloud.digitalocean.com/account/api/tokens | `string` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Domain name that points to `var.public_ip` | `string` | n/a | yes |
| <a name="input_droplet_image"></a> [droplet\_image](#input\_droplet\_image) | ID or slug identifier of the base image for the Droplet | `any` | `"debian-11-x64"` | no |
| <a name="input_droplet_size"></a> [droplet\_size](#input\_droplet\_size) | Slug identifier of the DigitalOcean Droplet size | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_droplet_tags"></a> [droplet\_tags](#input\_droplet\_tags) | List of DigitalOcean tags to be applied to the Droplet | `list(string)` | `[]` | no |
| <a name="input_enable_firewall"></a> [enable\_firewall](#input\_enable\_firewall) | Configure a DigitalOcean Firewall in front of the Droplet | `bool` | `true` | no |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | IP address of an **existing** DigitalOcean Floating IP | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | Slug identifier of the DigitalOcean data center region, e.g., sfo1 | `string` | n/a | yes |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | Linux server time zone, e.g., America/Los\_Angeles | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
