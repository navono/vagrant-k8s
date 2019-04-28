# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

$script = <<-SCRIPT
echo I am provisioning...
SCRIPT

IMAGE_NAME = "generic/ubuntu1804"
N = 2

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  # config.vm.box = "hashicorp/precise64"

  # need install plugin
  # vagrant plugin install vagrant-proxyconf
  # if Vagrant.has_plugin?("vagrant-proxyconf")
  #   config.proxy.http     = "http://192.168.56.1:8118/"
  #   config.proxy.https    = "http://192.168.56.1:8118/"
  #   config.proxy.no_proxy = "localhost,127.0.0.1,.example.com"
  # end

  #config.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_udp: false
  
  config.vm.define "kmaster" do |master|
    master.vm.define "kmaster"
    master.vm.box = IMAGE_NAME
    master.vm.network "private_network", ip: "192.168.56.100"

    # need install plugin
    # vagrant plugin install vagrant-disksize
    master.disksize.size = '150GB'
        
    # master.vm.provision "boot", type: "shell" , path: "./bootstrap.sh"
    # master.vm.provision "docker", type: "shell", path: "./install-docker-ce.sh"
    # master.vm.provision "k8s", type: "shell", path: "./install-k8s.sh"
    # master.vm.provision "master", type: "shell", path: "./start-k8s-master.sh"

    master.vm.provider :virtualbox do |vb|
      vb.name = "kmaster"
      vb.memory = "4096"
      vb.cpus = "2"
      vb.customize ["modifyvm", :id, "--groups", "/cluster"]
      end
  end

  (1..N).each do |i|
    config.vm.define "knode-#{i}" do |node|
      node.vm.box = IMAGE_NAME
      node.vm.network "private_network", ip: "192.168.56.#{i + 100}"
      node.vm.hostname = "node-#{i}"

      # need install plugin
      # vagrant plugin install vagrant-disksize
      node.disksize.size = '150GB'

      # node.vm.provision "boot", type: "shell" , path: "./bootstrap.sh"
      # node.vm.provision "docker", type: "shell", path: "./install-docker-ce.sh"
      # node.vm.provision "k8s", type: "shell", path: "./install-k8s.sh"
  
      node.vm.provider :virtualbox do |vb|
        vb.name = "node-#{i}"
        vb.memory = "4096"
        vb.cpus = "1"
        vb.customize ["modifyvm", :id, "--groups", "/cluster"]
      end
    end
  end

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
