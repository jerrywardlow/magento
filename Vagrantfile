# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :shell, path: "pass"
  config.vm.hostname = "pass"
  config.vm.network :private_network, ip: "pass"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder "pass/", "/pass"

  config.vm.provider "virtualbox" do |vb|
    vb.name = "pass"
  end
end
