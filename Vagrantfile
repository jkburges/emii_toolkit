# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu-12.04-omnibus-chef"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  config.vm.provision :chef_solo do |chef|

    chef.add_recipe "postgis"
    chef.add_recipe "database-provision"

    chef.json = {
      "postgresql" => {
        "password" => {
          "postgres"=> "postgres"
        }
      }
    }
  end

end
