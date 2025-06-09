# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'almalinux/10'
  config.vm.provider ('libvirt') do |vb|
    vb.memory = 1024 * 2
    vb.cpus = 2
  end
  config.vm.provision "shell", inline: <<-SHELL
    curl -fsSL https://raw.githubusercontent.com/YumaYX/Nova/main/init.sh | sudo sh
  SHELL
=begin
  config.vm.provision :ansible_local do |ansible|
    ansible.playbook = "init.yml"
    ansible.become = true
  end
=end
end

