
terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a wazuh server droplet
resource "digitalocean_droplet" "wazuh_server" {
  
  image    = "ubuntu-18-04-x64"
  name     = "example-1"
  region   = "nyc2"
  size     = "s-1vcpu-1gb"
  ssh_keys = [data.digitalocean_ssh_key.wazuh.fingerprint]
}