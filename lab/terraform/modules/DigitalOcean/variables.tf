################################################################################
# Optional Variables. These have defaults set don't need to be modified for    #
# this to run. Modify them to your liking if you desire.terraform              #
################################################################################


# Our DigitalOcean API token.
variable do_token {}


# Name of your SSH Key as it appears in the DigitalOcean dashboard
variable ssh_key {
    type = string
}


# Name of your project. Will be prepended to most resources
variable "wazuh" {
    type = string
    default = "minimal-vpc"
}


# The region to deploy our infrastructure to.
variable "region" {
    type    = string
    default = "nyc1"
}


# The operating system image we want to use. 
# Can view slugs (valid options) https://slugs.do-api.dev/
variable "image" {
    type = string
    default = "ubuntu-20-04-x64"
}


# The size we want our droplets to be. 
# Can view slugs (valid options) https://slugs.do-api.dev/
variable "droplet_size" {
    type = string
    default = "s-4vcpu-8gb"
}