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
