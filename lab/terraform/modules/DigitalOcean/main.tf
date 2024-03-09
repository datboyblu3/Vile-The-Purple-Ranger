################################################################################
# Create 2 servers with nginx installed on one and nginx installed on another  #
################################################################################


terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


# Create a wazuh server
resource "digitalocean_droplet" "wazuh" {
  image     = var.image
  name      = var.name
  region    = var.region
  size      = var.size
  ssh       = ssh_keys = [data.digitalocean_ssh_key.wazuh.id]
}