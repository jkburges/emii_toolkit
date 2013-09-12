# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu-12.04-omnibus-chef"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  config.vm.network :forwarded_port, guest: 5432, host: 15432

  config.vm.provision :chef_solo do |chef|

    chef.add_recipe "postgis"
    chef.add_recipe "database-provision"
    chef.add_recipe "liquibase"

    chef.json = {
      "postgresql" => {
        "config" => {
          "listen_addresses" => '*'
        },
        "pg_hba" => [{
          :type => 'host',
          :db => 'all',
          :user => 'postgres',
          :addr => '0.0.0.0/0',
          :method => 'md5'
        }],
        "password" => {
          "postgres"=> "postgres"
        }
      }
    }
  end

end
