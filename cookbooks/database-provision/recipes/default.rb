include_recipe 'postgis'
include_recipe 'liquibase'

# Database creation requires the pg gem.
include_recipe "postgresql::ruby"

# liquibase needs this to connect.
package 'libpostgresql-jdbc-java'

include_recipe 'git'

# Checkout database git repo
bash "install_something" do
  user "vagrant"
  cwd "/home/vagrant"
  code <<-EOH
  git clone https://github.com/jkburges/emii_db.git
  EOH
  not_if { ::File.exists?('/home/vagrant/emii_db') }
end

template '/usr/local/bin/generate_diff.sh' do
  mode 0755
end

# convenience script to generate liquibase changelog.
cookbook_file '/usr/local/bin/generate_changelog.sh' do
  mode 0755
end


['geoserver', 'geoserver_diff'].each do |database_name|

  connection = ({
                  :host => "localhost",
                  :port => 5432,
                  :username => 'postgres',
                  :password => node['postgresql']['password']['postgres']
                })

  # create a postgresql database
  postgresql_database database_name do
    connection connection
    template 'template_postgis'
    action :create
  end

  # Apply changelog
  liquibase_migrate 'migrate' do
    change_log_file '/home/vagrant/emii_db/changelog.xml'
    jar "#{node[:liquibase][:install_path]}/liquibase.jar"
    connection connection.merge(:database => database_name)
    classpath '/usr/share/java/postgresql-jdbc4.jar'
    driver 'org.postgresql.Driver'
    adapter :postgresql
  end
end
