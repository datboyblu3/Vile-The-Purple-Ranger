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
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt install vim",
      "sudo apt install curl",
      "sudo apt install net-tools",
      "sudo adduser --disabled-password --gecos '' dan",
      "sudo mkdir -p /home/dan/.ssh",
      "sudo touch /home/dan/.ssh/authorized_keys",
      "sudo echo '${file("~/.ssh/purple-team.pub")}' > authorized_keys",
      "sudo mv authorized_keys /home/dan/.ssh",
      "sudo chown -R serv:serv /home/dan/.ssh",
      "sudo chmod 700 /home/dan/.ssh",
      "sudo chmod 600 /home/dan/.ssh/authorized_keys",
      "sudo usermod -aG sudo dan",
      "sudo echo 'dan ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers"
    ]
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
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt install vim",
      "sudo apt install curl",
      "sudo apt install net-tools",
      "sudo adduser --disabled-password --gecos '' serv",
      "sudo mkdir -p /home/serv/.ssh",
      "sudo touch /home/serv/.ssh/authorized_keys",
      "sudo echo '${file("~/.ssh/purple-team.pub")}' > authorized_keys",
      "sudo mv authorized_keys /home/serv/.ssh",
      "sudo chown -R serv:serv /home/serv/.ssh",
      "sudo chmod 700 /home/serv/.ssh",
      "sudo chmod 600 /home/serv/.ssh/authorized_keys",
      "sudo usermod -aG sudo serv",
      "sudo echo 'serv ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers"
    ]
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
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt install vim",
      "sudo apt install curl",
      "sudo apt install net-tools",
      "sudo adduser --disabled-password --gecos '' dash",
      "sudo mkdir -p /home/dash/.ssh",
      "sudo touch /home/dash/.ssh/authorized_keys",
      "sudo echo '${file("~/.ssh/purple-team.pub")}' > authorized_keys",
      "sudo mv authorized_keys /home/dash/.ssh",
      "sudo chown -R dash:dash /home/dash/.ssh",
      "sudo chmod 700 /home/dash/.ssh",
      "sudo chmod 600 /home/dash/.ssh/authorized_keys",
      "sudo usermod -aG sudo dash",
      "sudo echo 'dash ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers"
    ]
  }

  /*provisioner "local-exec" {
    command = "ansible-playbook  -i ${self.network_interface.0.access_config.0.nat_ip}, --private-key ${local.private_key_path} nginx.yaml"
  }*/

}