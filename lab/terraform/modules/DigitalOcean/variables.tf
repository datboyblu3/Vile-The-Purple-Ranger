# Our DigitalOcean API token.
variable do_token {}

# Name of your SSH Key as it appears in the DigitalOcean dashboard
variable ssh_key {
    type = string
}

################################################################################
# Optional Variables. These have defaults set don't need to be modified for    #
# this to run. Modify them to your liking if you desire.terraform              #
################################################################################

# Name of your project. Will be prepended to most resources
variable "name" {
    type = string
    default = "minimal-vpc"
}
# The region to deploy our infrastructure to.
variable "region" {
    type    = string
    default = "nyc3"
}

variable "image" {
    type = string
    default = "ubuntu-20-04-x64"
}
