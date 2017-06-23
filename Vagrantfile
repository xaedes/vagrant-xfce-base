# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.1"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "C:/", "/home/ubuntu/mounted"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
  
    # Customize the amount of memory on the VM:
    vb.memory = "4096"

    file_to_disk = 'disk.vdi'
    unless File.exist?(file_to_disk)
      vb.customize ['createhd', '--filename', file_to_disk, '--size', 500 * 1024]
    end
    # vb.customize ['storagectl', :id, '--name', 'SATA Controller', '--add', 'sata', '--portcount', 4]
    vb.customize ['storageattach', :id, '--storagectl', 'SCSI', '--port', 3, '--device', 0, '--type', 'hdd', '--medium', file_to_disk]
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.

  config.vm.provision "cfg", type: "shell", inline: <<-SHELL
    sudo -H -u ubuntu cp -r /vagrant/cfg /home/ubuntu/
    sudo chown ubuntu:ubuntu /home/ubuntu/cfg
    sudo apt-get install -y stow 

    cd /home/ubuntu/cfg
    ./removeExistingTargets.sh
    sudo -H -u ubuntu stow bash
    sudo -H -u ubuntu stow xfce

  SHELL

  config.vm.provision "user", type: "shell", inline: <<-SHELL
    # set passwd
    sudo echo ubuntu:ubuntu | chpasswd
  SHELL

  config.vm.provision "system", type: "shell", inline: <<-SHELL

    sudo apt-get install -y htop 
    
    # gui
    sudo apt-get update
    sudo apt-get install -y xfce4
    sudo apt-get install -y slim 

    # german keyboard layout
    echo setxkbmap -layout de >> /home/ubuntu/.profile
    setxkbmap -layout de

    # enable auto_login
    sudo sed -i -r 's/^#?auto_login.*$/auto_login yes/' /etc/slim.conf
    sudo sed -i -r 's/^#?focus_password.*$/focus_password yes/' /etc/slim.conf
    sudo sed -i -r 's/^#?default_user.*$/default_user ubuntu/' /etc/slim.conf

    # sudo sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config
    # echo "done"

  SHELL

  config.vm.provision "extraDisc", type: "shell", inline: <<-SHELL
    sudo mkfs.ext4 /dev/sdc
    cd /home/ubuntu/
    sudo -H -u ubuntu mkdir disc
    sudo chown ubuntu:ubuntu /home/ubuntu/disc
    sudo echo /dev/sdc  /home/ubuntu/disc  ext4  defaults  0 0 >> /etc/fstab
  SHELL

  config.vm.provision "update", type: "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get -y upgrade
  SHELL

end
