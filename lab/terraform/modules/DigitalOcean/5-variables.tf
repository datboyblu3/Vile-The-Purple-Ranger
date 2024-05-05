################################################################################
# Optional Variables. These have defaults set don't need to be modified for    #
# this to run. Modify them to your liking if you desire.terraform              #
################################################################################

#The DigitalOcean API token
variable "do_token" {
  description = "Digital Ocean API Key"
  type        = string
  sensitive   = true
}

# Name of your project. Will be prepended to most resources
variable "name" {
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
    default = "	ubuntu-22-04-x64"
}

# The size we want our droplet images to be to be.
variable "size" {
    type = string
    default = "s-2vcpu-4gb-amd"
}