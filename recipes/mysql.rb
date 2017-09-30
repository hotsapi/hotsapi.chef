bash "mysql-password" do
  code <<-EOH
    debconf-set-selections <<< 'mysql-server mysql-server/root_password password #{node['hotsapi']['env']['DB_PASSWORD']}'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password #{node['hotsapi']['env']['DB_PASSWORD']}'
  EOH
end

package 'mysql-server'

bash "mysql-create-db" do
  code "echo 'CREATE DATABASE IF NOT EXISTS #{node['hotsapi']['env']['DB_DATABASE']}' | mysql -p#{node['hotsapi']['env']['DB_PASSWORD']}"
end
