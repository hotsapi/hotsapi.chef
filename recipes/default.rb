##### Laravel app #####

package %w(php7.0 php7.0-fpm php7.0-mysql php7.0-zip php7.0-gd mcrypt php7.0-mcrypt php7.0-mbstring php7.0-xml php7.0-curl php7.0-json composer zip unzip nginx memcached php-memcached git)

service 'nginx'
service 'php7.0-fpm'

# Don't use built in git resource because it doesn't track branch
execute "hotsapi-git" do
  cwd "/var/www"
  creates "/var/www/hotsapi"
  command "git clone https://github.com/poma/hotsapi.git"
  live_stream true
end

cookbook_file '/etc/nginx/sites-available/hotsapi.conf' do
  notifies :restart, "service[nginx]"
end

cookbook_file '/etc/nginx/nginx.conf' do
  notifies :restart, "service[nginx]"
end

cookbook_file '/etc/php/7.0/fpm/pool.d/www.conf' do
  notifies :restart, "service[php7.0-fpm]"
end

cookbook_file '/etc/php/7.0/fpm/php.ini' do
  notifies :restart, "service[php7.0-fpm]"
end

cookbook_file '/etc/cron.d/laravel' do
  source "laravel.cron"
end

template '/var/www/hotsapi/.env' do
  source '.env.erb'
  variables({
    :env => node['hotsapi']['env']
  })
end

execute "hotsapi-deploy-script" do
  cwd "/var/www/hotsapi"
  command "./deploy.sh"
  live_stream true
end

##### Hero protocol #####

package "python"

# Don't use built in git resource because it doesn't track branch
execute "heroprotocol-git" do
  cwd "/opt"
  creates "/opt/heroprotocol"
  command "git clone https://github.com/Blizzard/heroprotocol.git"
  live_stream true
end

link '/usr/bin/heroprotocol' do
  to '/opt/heroprotocol/heroprotocol.py'
end

file '/opt/heroprotocol/heroprotocol.py' do
  mode '755'
end

cookbook_file '/etc/cron.hourly/heroprotocol' do
  source "heroprotocol.cron"
  mode '755'
end

##### General #####

cookbook_file '/etc/rc.local'
