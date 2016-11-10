# -*- mode: ruby -*-
# vi: set ft=ruby :

# user-configurable DO settings
require 'yaml'
settings = YAML.load_file('settings.yaml')

Vagrant.configure("2") do |config|

  ##############################
  # PROVIDER SPECIFIC SETTINGS #
  ##############################
  config.vm.provider "virtualbox" do |vb, override|
    override.vm.box = "bento/ubuntu-14.04"
    override.vm.provision "shell", path: "scripts/provision_virtualbox.sh"
  end
  
  config.vm.provider "hyperv" do |hyperv, override|
    override.vm.box = "ericmann/trusty64"
    override.vm.provision "shell", path: "scripts/provision_hyperv.sh"
  end
  
  config.vm.provider "digital_ocean" do |digitalocean, override|
    override.ssh.private_key_path = settings['DO']['keypath']
    override.ssh.username = 'vagrant'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    digitalocean.token = settings['DO']['token']
    digitalocean.image = 'ubuntu-14-04-x64'
    digitalocean.region = settings['DO']['region']
    digitalocean.size = '1gb'
    digitalocean.ipv6 = true
    digitalocean.backups_enabled = false
    
    override.vm.provision "shell", path: "scripts/provision_digitalocean.sh"
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
  
  config.vm.provision "shell", path: "scripts/provision_all_providers.sh"
  
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.provisioning_path = "/home/vagrant/guestfiles"
  end
end