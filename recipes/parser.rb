apt_repository 'microsoft' do
  uri 'https://packages.microsoft.com/ubuntu/16.04/prod'
  components ['main']
  arch 'amd64'
  distribution 'xenial'
  key 'https://packages.microsoft.com/keys/microsoft.asc'
end

package 'dotnet-runtime-2.0.0'

execute "get-hotsapi-parser" do
  cwd "/opt"
  creates "/opt/hotsapi-parser"
  command "mkdir hotsapi-parser && cd hotsapi-parser && curl https://s3-eu-west-1.amazonaws.com/poma/Hotsapi.Parser/master/latest/parser.tar.gz > parser.tar.gz && tar -xzf parser.tar.gz"
  live_stream true
end

link '/usr/bin/hotsapi-parser' do
  to '/opt/hotsapi-parser/parser.sh'
end

file '/opt/hotsapi-parser/parser.sh' do
  mode '755'
end