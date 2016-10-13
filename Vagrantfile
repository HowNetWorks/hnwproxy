# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  ##############################
  # PROVIDER SPECIFIC SETTINGS #
  ##############################
  config.vm.provider "virtualbox" do |vb|
    config.vm.box = "bento/ubuntu-14.04"
  end
  
  config.vm.provider "hyperv" do | hyperv |
	config.vm.box = "ericmann/trusty64"
  end
  
  ##############################
  # SETTINGS FOR ALL PROVIDERS #
  ##############################
 
  config.vm.hostname = "hnwProxy"
  
  # disable folder sync
  config.vm.synced_folder ".", "/vagrant", disabled: true
	
  ################
  # PROVISIONERS #
  ################
  
  # upload guest files
  config.vm.provision "file", source: "guestfiles", destination: "/home/vagrant"
  
  config.vm.provision "shell", path: "provision_all_platforms.sh"
  
  config.vm.provision "ansible_local" do |ansible|
	ansible.playbook = "playbook.yml"
	ansible.provisioning_path = "/home/vagrant/guestfiles"
  end
end