######################################################################################
# Creates three droplets the wazuh indexer, server and dashboard. And the SSH keys #
# Edits to make:
# 1 - move installs into a bash script
######################################################################################



resource "digitalocean_ssh_key" "ssh_key" {
  name       = "PurpleTeam"
  public_key = file("~/.ssh/purple-team.pub")
}


resource "digitalocean_droplet" "indexer" {
  name               = "wazuh-indexer"
  region             = var.region
  size               = var.size
  image              = var.image
  tags               = [digitalocean_tag.purple_team_project.id]
  ssh_keys = [
    digitalocean_ssh_key.ssh_key.fingerprint
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    agent       = false
    timeout     = "3m"
    private_key = file("~/.ssh/purple-team")
  }
  
resource "null_resource" "setup"{
  provisioner "local-exec"{
    command = "/Users/dan/Documents/GitHub Projects/Vile-The-Purple-Ranger/lab/scripts setup.sh"
  }
}
  /*provisioner "local-exec" {
    #command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} nginx.yaml"
  }*/
}


resource "digitalocean_droplet" "server" {
  name               = "wazuh-server"
  region             = var.region
  size               = var.size
  image              = var.image
  tags               = [digitalocean_tag.purple_team_project.id]
  ssh_keys = [
    digitalocean_ssh_key.ssh_key.fingerprint
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    agent       = false
    timeout     = "3m"
    private_key = file("~/.ssh/purple-team")
  }
 
 resource "null_resource" "setup"{
  provisioner "local-exec"{
    command = "/Users/dan/Documents/GitHub Projects/Vile-The-Purple-Ranger/lab/scripts setup.sh"
  }
}

  /*provisioner "local-exec" {
    #command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} nginx.yaml"
  }*/

}


resource "digitalocean_droplet" "dashboard" {
  name               = "wazuh-dashboard"
  region             = var.region
  size               = var.size
  image              = var.image
  tags               = [digitalocean_tag.purple_team_project.id]
  ssh_keys = [
    digitalocean_ssh_key.ssh_key.fingerprint
  ]
  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    agent       = false
    timeout     = "3m"
    private_key = file("~/.ssh/purple-team")
  }

  resource "null_resource" "setup"{
  provisioner "local-exec"{
    command = "/Users/dan/Documents/GitHub Projects/Vile-The-Purple-Ranger/lab/scripts setup.sh"
  }
}

  /*provisioner "local-exec" {
    command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} nginx.yaml"
  }*/

}