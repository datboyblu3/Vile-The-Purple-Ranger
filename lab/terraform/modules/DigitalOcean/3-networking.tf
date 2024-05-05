################################################################################
# Create a VPC for isolating our traffic                                       #
################################################################################
resource "digitalocean_vpc" "vpc"{
    # The human friendly name of our VPC.
    name = "purple-team-project-vpc2"

    # The region to deploy our VPC to.
    region = var.region

    # The private ip range within our VPC
    ip_range = "10.220.50.0/24"
}