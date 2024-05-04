output "wazuh_server_public_ip" {
  value = digitalocean_droplet.server.ipv4_address
}

output "wazuh_server_public_ip" {
  value = digitalocean_droplet.indexer.ipv4_address
}

output "wazuh_server_public_ip" {
  value = digitalocean_droplet.dashboard.ipv4_address
}

output "wazuh_dashboard_url" {
  value = "http://${digitalocean_droplet.dashboard.ipv4_address}"
}