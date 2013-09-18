include_recipe 'postgis'
include_recipe 'liquibase'

# Database creation requires the pg gem.
include_recipe "postgresql::ruby"

# liquibase needs this to connect.
package 'libpostgresql-jdbc-java'

include_recipe 'git'

# Checkout database git repo
directory node['development']['workspace'] do
  owner 'vagrant'
  group 'vagrant'
end

bash "install_something" do
  user 'vagrant'
  group 'vagrant'
  cwd node['development']['workspace']
  code <<-EOH
  git clone https://github.com/jkburges/emii_db.git
  EOH
  not_if { ::File.exists?("#{node['development']['workspace']}/emii_db") }
end

template "#{node['development']['workspace']}/liquibase.properties" do
  mode 0644
end

directory "#{node['development']['workspace']}/bin" do
  owner 'vagrant'
  group 'vagrant'
end

template "#{node['development']['workspace']}/bin/run_liquibase.sh" do
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
    change_log_file "#{node['development']['workspace']}/emii_db/changelog.xml"
    jar "#{node[:liquibase][:install_path]}/liquibase.jar"
    connection connection.merge(:database => database_name)
    classpath '/usr/share/java/postgresql-jdbc4.jar'
    driver 'org.postgresql.Driver'
    adapter :postgresql
  end
end
