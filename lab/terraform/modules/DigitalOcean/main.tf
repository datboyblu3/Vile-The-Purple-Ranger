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
  size      = var.wazuh_droplet_size
  ssh       = ssh_keys = [data.digitalocean_ssh_key.wazuh.id]
  vpc_uuid = digitalocean_vpc.vpc.id
}


# Create a nginx server
resource "digitalocean_droplet" "nginx" {
  image     = var.image
  name      = var.name
  region    = var.region
  size      = var.nginx_droplet_size
  ssh       = ssh_keys = [data.digitalocean_ssh_key.wazuh.id]
  vpc_uuid = digitalocean_vpc.vpc.id



  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.network_interface.0.access_config.0.nat_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} nginx.yaml"
  }
}

#Create an internet gateway
resource "digitalocean_droplet" "gateway"{
  image     = var.image
  name      = var.name
  region    = var.region
  size      = var.nginx_droplet_size
  ssh       = ssh_keys = [data.digitalocean_ssh_key.gateway.id]
  vpc_uuid = digitalocean_vpc.vpc.id




  provisioner "remote-exec" {
    inline = ["echo 'Wait until SSH is ready'"]

    connection {
      type        = "ssh"
      user        = local.ssh_user
      private_key = file(local.private_key_path)
      host        = self.network_interface.0.access_config.0.nat_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} server_config.yaml" #CHANGE THIS TO REFLECT YOUR INFRASTRUCTURE
  }
}


################################################################################
# Create a certificate for SSL for our Load Balancer                           #
################################################################################
resource "digitalocean_certificate" "web" {

    # Human friendly name of the certificate
    name = "${var.name}-certificate"

    # type of certificate. Use Let's Encrypt to create the ticket
    type = "lets_encrypt"

    # The fqdn to get the certificate for
    domains = ["${var.subdomain}.${data.digitalocean_domain.web.name}"]

    # Ensure we create a new certificate successfully before deleting the old
    # one
    lifecycle {
        create_before_destroy = true
    }
}
################################################################################
# Load Balancer for distributing traffic amongst our web servers. Uses SSL     #
# termination and forwards HTTPS traffic to HTTP internally                    #
################################################################################
resource "digitalocean_loadbalancer" "web" {

    # The user friendly name of the load balancer
    name = "web-${var.region}"

    # What region to deploy the LB to
    region = var.region

    # Which droplets should the load balancer route traffic to
    droplet_ids = digitalocean_droplet.web.*.id

    # What VPC to put the load balancer in
    vpc_uuid = digitalocean_vpc.web.id

    # Force all HTTP traffic to come through via HTTPS
    redirect_http_to_https = true
    
    #--------------------------------------------------------------------------#
    # Forward all traffic received on port 443 using the http protocol to       #
    # Port 80 using the http protocol of the hosts behind this load balancer   #
    #--------------------------------------------------------------------------#
    forwarding_rule {
        entry_port = 443
        entry_protocol = "https"

        target_port = 80
        target_protocol = "http"

        certificate_id = digitalocean_certificate.web.id
    }

    forwarding_rule {
        entry_port = 80
        entry_protocol = "http"

        target_port = 80
        target_protocol = "http"

        certificate_id = digitalocean_certificate.web.id
    }

    #-----------------------------------------------------------------------------------------------#
    # Ensures that we create the new resource before we destroy the old one                         #
    # https://www.terraform.io/docs/configuration/resources.html#lifecycle-lifecycle-customizations #
    #-----------------------------------------------------------------------------------------------#
    lifecycle {
        create_before_destroy = true
    }
}

################################################################################
# Firewall Rules for our Webserver Droplets                                    #
################################################################################
resource "digitalocean_firewall" "web" {

    # The name we give our firewall for ease of use                            #    
    name = "minimal-vpc-only-vpc-traffic"

    # The droplets to apply this firewall to                                   #
    droplet_ids = digitalocean_droplet.web.*.id

    #--------------------------------------------------------------------------#
    # Internal VPC Rules. We have to let ourselves talk to each other          #
    #--------------------------------------------------------------------------#
    inbound_rule {
        protocol = "tcp"
        port_range = "1-65535"
        source_addresses = [digitalocean_vpc.vpc.ip_range]
    }

    inbound_rule {
        protocol = "udp"
        port_range = "1-65535"
        source_addresses = [digitalocean_vpc.vpc.ip_range]
    }

    inbound_rule {
        protocol = "icmp"
        source_addresses = [digitalocean_vpc.vpc.ip_range]
    }

    outbound_rule {
        protocol = "udp"
        port_range = "1-65535"
        destination_addresses = [digitalocean_vpc.vpc.ip_range]
    }

    outbound_rule {
        protocol = "tcp"
        port_range = "1-65535"
        destination_addresses = [digitalocean_vpc.vpc.ip_range]
    }

    outbound_rule {
        protocol = "icmp"
        destination_addresses = [digitalocean_vpc.vpc.ip_range]
    }

    #--------------------------------------------------------------------------#
    # Selective Outbound Traffic Rules                                         #
    #--------------------------------------------------------------------------#

    # DNS
    outbound_rule {
        protocol = "udp"
        port_range = "53"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    # HTTP
    outbound_rule {
        protocol = "tcp"
        port_range = "80"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    # HTTPS
    outbound_rule {
        protocol = "tcp"
        port_range = "443"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }

    # ICMP (Ping)
    outbound_rule {
        protocol              = "icmp"
        destination_addresses = ["0.0.0.0/0", "::/0"]
    }
}

################################################################################
# Create a DNS A record for our loadbalancer. The name will be the region we   #
# chose.                                                                       #
################################################################################
resource "digitalocean_record" "web" {

    # Get the domain from our data source
    domain = data.digitalocean_domain.web.name

    # An A record is an IPv4 name record. Like www.digitalocean.com
    type   = "A"

    # Set the name to the region we chose. Can be anything
    name   = var.subdomain

    # Point the record at the IP address of our load balancer
    value  = digitalocean_loadbalancer.web.ip

    # The Time-to-Live for this record is 30 seconds. Then the cache invalidates
    ttl    = 300
}
