package %w(php7.0 php7.0-fpm php7.0-mysql php7.0-zip php7.0-gd mcrypt php7.0-mcrypt php7.0-mbstring php7.0-xml php7.0-curl php7.0-json composer zip unzip nginx git)

git '/var/www/hotsapi' do
  repository "https://github.com/poma/hotsapi.git"
  action :checkout
  notifies :run, 'execute[hotsapi-deploy-script]'
end

cookbook_file '/etc/nginx/sites-available/default' do
  source "nginx.conf"
  notifies :restart, "service[nginx]"
end

execute "hotsapi-deploy-script" do
  cwd "/var/www/hotsapi"
  command "./deploy.sh"
  user "root"
  action :nothing
end


package "python"

git '/opt/heroprotocol' do
  repository "https://github.com/Blizzard/heroprotocol.git"
  revision 'master'
  action :checkout
end

link '/usr/bin/heroprotocol' do
  to '/opt/heroprotocol/heroprotocol.py'
end

file '/opt/heroprotocol/heroprotocol.py' do
  mode 755
end

cookbook_file '/etc/cron.daily/heroprotocol' do
  source "heroprotocol.cron"
  mode 755
end
