# -*- mode: ruby -*-
# vi: set ft=ruby :

servers=[
      {
        :hostname => "app1",
        :ip => "10.69.1.2",
        :box => "CentOS-7.6.1810",
        :memory => 512,
        :cpus => 1,
        :role => "app",
        :group => "dc1"
      },
      {
        :hostname => "db1",
        :ip => "10.69.1.3",
        :box => "CentOS-7.6.1810",
        :memory => 512,
        :cpus => 1,
        :role => "db",
        :group => "dc1"
      },
      {
        :hostname => "mon1",
        :ip => "10.69.1.4",
        :box => "CentOS-7.6.1810",
        :memory => 512,
        :cpus => 1,
        :role => "mon",
        :group => "dc1"
      },
      {
        :hostname => "app2",
        :ip => "10.69.2.2",
        :box => "CentOS-7.6.1810",
        :memory => 512,
        :cpus => 1,
        :role => "app",
        :group => "dc2"
      },
      {
        :hostname => "db2",
        :ip => "10.69.2.3",
        :box => "CentOS-7.6.1810",
        :memory => 512,
        :cpus => 1,
        :role => "db",
        :group => "dc2"
      },
      {
        :hostname => "mon2",
        :ip => "10.69.2.4",
        :box => "CentOS-7.6.1810",
        :memory => 512,
        :cpus => 1,
        :role => "mon",
        :group => "dc2"
      }
]

Vagrant.configure("2") do |config|
  config.vbguest.auto_update = false
  config.vm.box_check_update = false
  config.vm.box = "CentOS-7.6.1810"
  config.ssh.insert_key = false
    
  config.vm.define "control" do |control|
    control.vm.hostname = "control"

    config.vm.provider "virtualbox" do |vb|
      vb.name = "control"
      vb.memory = "512"
      vb.cpus = "1"
    end

    control.vm.network "public_network", ip: "192.168.69.3", bridge: "em1"
    control.vm.network "private_network", ip: "10.69.1.1"
    control.vm.network "private_network", ip: "10.69.2.1"
    control.vm.provision "shell", path: "provision/control.sh"
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
        node.vm.provision "shell", path: "provision/app.sh"
      when "db"
        node.vm.provision "shell", path: "provision/db.sh"
      when "mon"
        node.vm.provision "shell", path: "provision/mon.sh"
      end
    end
  end

  config.vm.provision "shell", path: "provision/common.sh"
end