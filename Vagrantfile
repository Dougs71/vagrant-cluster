# -*- mode: ruby -*-
# vi: set ft=ruby :

servers=[
  {
    :hostname => "qa-prod-app",
    :ip => "10.129.242.5",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "app",
    :group => "qa"
  },
  {
    :hostname => "qa-prod-db",
    :ip => "10.129.242.4",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "db",
    :group => "qa"
  },
  {
    :hostname => "qa-fail-app",
    :ip => "10.129.242.7",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "app",
    :group => "qa"
  },
  {
    :hostname => "qa-fail-db",
    :ip => "10.129.242.6",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "db",
    :group => "qa"
  },
  {
    :hostname => "prod-app",
    :ip => "10.129.208.5",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "app",
    :group => "prod"
  },
  {
    :hostname => "prod-db",
    :ip => "10.129.208.4",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "db",
    :group => "prod"
  },
  {
    :hostname => "prod-mon",
    :ip => "10.129.208.6",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "mon",
    :group => "prod"
  },
  {
    :hostname => "fail-app",
    :ip => "10.129.228.67",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "app",
    :group => "fail"
  },
  {
    :hostname => "fail-db",
    :ip => "10.129.228.66",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "db",
    :group => "fail"
  },
  {
    :hostname => "fail-mon",
    :ip => "10.129.228.68",
    :box => "Dougs71/CentOS-7.6.1810-Minimal",
    :memory => 512,
    :cpus => 1,
    :role => "mon",
    :group => "fail"
  }
]

Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.box_check_update = false
  config.vm.box = "Dougs71/CentOS-7.6.1810-Minimal"
  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  config.ssh.insert_key = false
  config.ssh.private_key_path = ['provision/vagrant']

  config.vm.define "control" do |control|
    control.vm.hostname = "control"

    config.vm.provider "virtualbox" do |vb|
      vb.name = "control"
      vb.memory = "512"
      vb.cpus = "1"
    end

    control.vm.network "public_network", ip: "192.168.69.3", bridge: "em1"
    control.vm.network "private_network", ip: "10.129.242.1"
    control.vm.network "private_network", ip: "10.129.208.1"
    control.vm.network "private_network", ip: "10.129.228.1"
    control.vm.provision "shell", path: "provision/control.sh", privileged: false
  end

  servers.each do |machine|
    config.vm.define machine[:hostname] do |node|
      node.vm.box = machine[:box]
      node.vm.hostname = machine[:hostname]
      node.vm.network "private_network", ip: machine[:ip]

      node.vm.provider "virtualbox" do |vb|
        vb.memory = machine[:memory]
        vb.cpus = machine[:cpus]
        vb.name = machine[:hostname]
      end

      case machine[:role]
      when "app"
        node.vm.provision "shell", path: "provision/app.sh", privileged: false
      when "db"
        node.vm.provision "shell", path: "provision/db.sh", privileged: false
      when "mon"
        node.vm.provision "shell", path: "provision/mon.sh", privileged: false
      end
    end
  end

  config.vm.provision "shell", path: "provision/common.sh", privileged: false
end