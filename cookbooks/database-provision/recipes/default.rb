include_recipe 'postgis'
include_recipe 'liquibase'

# Database creation requires the pg gem.
include_recipe "postgresql::ruby"

# create a postgresql database
postgresql_database 'geoserver' do
  connection ({:host => "localhost", :port => 5432, :username => 'postgres', :password => node['postgresql']['password']['postgres']})
  template 'template_postgis'
  action :create
end

# liquibase needs this to connect.
package 'libpostgresql-jdbc-java'

include_recipe 'git'

# TODO: checkout database git repo

# TODO: apply changelog


# convenience script to generate liquibase changelog.
# TODO: fork the liquibase cookbook and add other commands.
cookbook_file '/tmp/generate_changelog.sh' do
  source 'generate_changelog.sh'
  mode 0755
end
