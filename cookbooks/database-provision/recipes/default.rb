# Database creation requires the pg gem.
include_recipe "postgresql::ruby"

# create a postgresql database
postgresql_database 'geoserver' do
  connection ({:host => "localhost", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  template 'template_postgis'
  action :create
end
