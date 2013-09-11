# create a postgresql database
postgresql_database 'geoserver' do
  connection ({:host => "localhost", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  action :create
end
