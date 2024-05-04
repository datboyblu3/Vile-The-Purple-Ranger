######################################################################################
# Create firewall rules for allowing traffic for updates and ssh from your machines  #
######################################################################################
resource "digitalocean_firewall" "firewall" {
  name = "purpleteam-firewall"

  droplet_ids = [digitalocean_droplet.purple_team_project.id]
  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0"] #CHANGE TO YOUR MACHINE IPs!
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0"] #CHANGE TO YOUR MACHINE IPs!
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"] #CHANGE TO YOUR MACHINE IPs!
  }
  inbound_rule {
    protocol         = "tcp"
    port_range       = "9200"
    source_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0"]
  }
}

################################################################################
# Create a VPC for isolating our traffic                                       #
################################################################################
resource "digitalocean_vpc" "vpc"{
    # The human friendly name of our VPC.
    name = "purple_team_project_vpc"

    # The region to deploy our VPC to.
    region = var.region

    # The private ip range within our VPC
    ip_range = "10.220.50.0/24"
}