      export PATH=$PATH:/usr/bin
      sudo apt-get update
      sudo apt install vim
      sudo apt install curl
      sudo apt-get -y install python3-pip
      sudo apt-get install openssh-client
      sudo apt install net-tools
      sudo adduser --disabled-password --gecos '' dan
      sudo mkdir -p /home/dan/.ssh
      sudo touch /home/dan/.ssh/authorized_keys
      sudo echo '${file("~/.ssh/purple-team.pub")}' > authorized_keys
      sudo mv authorized_keys /home/dan/.ssh
      sudo chown -R serv:serv /home/dan/.ssh
      sudo chmod 700 /home/dan/.ssh
      sudo chmod 600 /home/dan/.ssh/authorized_keys
      sudo usermod -aG sudo dan
      sudo echo 'dan ALL=(ALL) NOPASSWD:ALL' | sudo tee -a /etc/sudoers
