# -*- mode: ruby -*-
# vi: set ft=ruby :

node = {
  hostname: "magento",
  box: "ubuntu/xenial64",
  config: "provision/shell/magento.sh",
  ip: "192.168.56.50",
  synchost: "sync/",
  syncguest: "/sync"
}

# node = {
#   hostname: "magento",
#   box: "centos/7",
#   config: "provision/shell/macentos.sh",
#   ip: "192.168.56.50",
#   synchost: "sync/",
#   syncguest: "/sync"
# }

shell_script_args = [
  ENV['MAGENTO_PUBLIC'],
  ENV['MAGENTO_PRIVATE'],
  node[:ip]
]

Vagrant.configure("2") do |config|
  config.vm.box = node[:box]
  config.vm.hostname = node[:hostname]
  config.vm.network :private_network, ip: node[:ip]
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.vm.synced_folder node[:synchost], node[:syncguest]

  config.vm.provision :shell do |p|
    p.path = node[:config]
    p.args = shell_script_args
    p.privileged = false
  end

  config.vm.provider "virtualbox" do |vb|
    vb.name = node[:hostname]
  end
end
