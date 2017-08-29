package %w(php7.0 php7.0-fpm php7.0-mysql php7.0-zip php7.0-gd mcrypt php7.0-mcrypt php7.0-mbstring php7.0-xml php7.0-curl php7.0-json composer zip unzip nginx memcached php-memcached redis-server git)

service 'nginx'
service 'php7.0-fpm'

git '/var/www/hotsapi' do
  repository "https://github.com/poma/hotsapi.git"
  action :checkout
end

cookbook_file '/etc/nginx/sites-available/default' do
  source "nginx.conf"
  notifies :restart, "service[nginx]"
end

cookbook_file '/etc/php/7.0/fpm/php.ini' do
  notifies :restart, "service[php7.0-fpm]"
end

template '/var/www/hotsapi/.env' do
  source '.env.erb'
  variables({
    :env => node['hotsapi']['env']
  })
end

#execute "hotsapi-deploy-script" do
#  cwd "/var/www/hotsapi"
#  command "./deploy.sh"
#  user "root"
#end


package "python"

git '/opt/heroprotocol' do
  repository "https://github.com/Blizzard/heroprotocol.git"
  revision 'master'
  action :checkout
end

link '/usr/bin/heroprotocol' do
  to '/opt/heroprotocol/heroprotocol.py'
end

# for some reason file mode can be broken
file '/opt/heroprotocol/heroprotocol.py' do
  mode 755
end

cookbook_file '/etc/cron.hourly/heroprotocol' do
  source "heroprotocol.cron"
  mode 755
end
