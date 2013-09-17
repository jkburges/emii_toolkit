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

# convenience script to generate liquibase changelog.
cookbook_file '/tmp/generate_changelog.sh' do
  source 'generate_changelog.sh'
  mode 0755
end
