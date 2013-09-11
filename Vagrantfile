# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu-12.04-omnibus-chef"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"

    chef.add_recipe "postgis"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
    chef.json = {
      "postgresql" => {
        "password" => {
          "postgres"=> "postgres"
        }
      }
    }
  end

end
