resource "pwddigitalocean_ssh_key" "ssh_key" {
  name       = "PurpleTeam"
  public_key = file("~/.ssh/purpleteam.pub")
}


resource "digitalocean_droplet" "indexer" {
  image              = "ubuntu-20-04-x64"
  name               = "wazuh_indexer"
  region             = "nyc1"
  size               = "s-2vcpu-4gb"
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
    private_key = file("~/.ssh/purpleteam")
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
      "sudo echo '${file("~/.ssh/purpleteam.pub")}' > authorized_keys",
      "sudo mv authorized_keys /home/dan/.ssh",
      "sudo chown -R serv:serv /home/dan/.ssh",
      "sudo chmod 700 /home/dan/.ssh",
      "sudo chmod 600 /home/dan/.ssh/authorized_keys",
      "sudo usermod -aG sudo dan",
      "sudo echo 'dan ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers"
    ]
  }
}


resource "digitalocean_droplet" "server" {
  image              = "ubuntu-20-04-x64"
  name               = "wazuh_server"
  region             = "nyc1"
  size               = "s-2vcpu-4gb"
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
    private_key = file("~/.ssh/purpleteam")
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
      "sudo echo '${file("~/.ssh/hackerops.pub")}' > authorized_keys",
      "sudo mv authorized_keys /home/serv/.ssh",
      "sudo chown -R serv:serv /home/serv/.ssh",
      "sudo chmod 700 /home/serv/.ssh",
      "sudo chmod 600 /home/serv/.ssh/authorized_keys",
      "sudo usermod -aG sudo serv",
      "sudo echo 'serv ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers"
    ]
  }
}


resource "digitalocean_droplet" "dashboard" {
  image              = "ubuntu-20-04-x64"
  name               = "wazuh_dashboard"
  region             = "nyc1"
  size               = "s-2vcpu-4gb"
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
    private_key = file("~/.ssh/purpleteam")
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "sudo apt-get update",
      "sudo apt install vim",
      "sudo apt install curl",
      "sudo apt install net-tools",
      "sudo adduser --disabled-password --gecos '' dash",
      "sudo mkdir -p /home/serv/.ssh",
      "sudo touch /home/serv/.ssh/authorized_keys",
      "sudo echo '${file("~/.ssh/purpleteam.pub")}' > authorized_keys",
      "sudo mv authorized_keys /home/dash/.ssh",
      "sudo chown -R serv:serv /home/dash/.ssh",
      "sudo chmod 700 /home/dash/.ssh",
      "sudo chmod 600 /home/dash/.ssh/authorized_keys",
      "sudo usermod -aG sudo dash",
      "sudo echo 'dash ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers"
    ]
  }
}


