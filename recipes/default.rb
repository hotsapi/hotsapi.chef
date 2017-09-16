include_recipe 'apt'

if node['hotsapi']['install_mysql']
  include_recipe 'hotsapi::mysql'
end
include_recipe 'hotsapi::laravel'
include_recipe 'hotsapi::heroprotocol'

cookbook_file '/etc/rc.local'