package %w(php7.0 php7.0-fpm php7.0-mysql php7.0-zip php7.0-gd mcrypt php7.0-mcrypt php7.0-mbstring php7.0-xml php7.0-curl php7.0-json composer zip unzip nginx memcached php-memcached supervisor git)

service 'nginx'
service 'php7.0-fpm'

# Don't use built in git resource because it doesn't track branch
execute "hotsapi-git" do
  cwd "/var/www"
  creates "/var/www/hotsapi"
  command "git clone https://github.com/poma/hotsapi.git"
  live_stream true
end

# Those are dummy self-signed certificates, not the ones used in production
cookbook_file '/etc/ssl/certs/hotsapi.chained.pem' do
  source 'ssl-cert-snakeoil.pem'
  mode '644'
  action :create_if_missing
  notifies :reload, "service[nginx]"
end

cookbook_file '/etc/ssl/private/hotsapi.key' do
  source 'ssl-cert-snakeoil.key'
  mode '640'
  action :create_if_missing
  notifies :reload, "service[nginx]"
end

cookbook_file '/etc/nginx/sites-available/default' do
  source "hotsapi.conf"
  notifies :reload, "service[nginx]"
end

cookbook_file '/etc/nginx/nginx.conf' do
  notifies :reload, "service[nginx]"
end

cookbook_file '/etc/php/7.0/fpm/pool.d/www.conf' do
  notifies :reload, "service[php7.0-fpm]"
end

cookbook_file '/etc/php/7.0/fpm/php.ini' do
  notifies :reload, "service[php7.0-fpm]"
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

# Generate a new app key if not axists
execute "hotsapi-generate-key" do
  cwd "/var/www/hotsapi"
  command "grep -Fxq 'APP_KEY=' /var/www/hotsapi/.env && php artisan key:generate"
  live_stream true
end

# supervisor cookbook seems to be in ususable state so we will configure it manually
cookbook_file "/etc/supervisor/conf.d/laravel-worker.conf"

execute "supervisor-start" do
  command "supervisorctl reread && supervisorctl update && supervisorctl start laravel-worker:*"
  live_stream true
end
