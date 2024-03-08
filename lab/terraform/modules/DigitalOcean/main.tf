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
  image     = "ubuntu-20-04-x64"
  name      = "wazuh"
  region    = "nyc1"
  size      = "s-1vcpu-1gb"
  ssh       = ssh_keys = [data.digitalocean_ssh_key.wazuh.id]
}