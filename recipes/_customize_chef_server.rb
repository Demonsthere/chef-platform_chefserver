cookbook_file '/etc/chef-server/chef-server.rb' do
  source 'chef-server.rb'
  owner 'root'
  group 'root'
  mode '0644'
end

cookbook_file '/etc/chef-server/chef-validator.pem' do
  source 'chef-validator.pem'
  owner 'root'
  group 'root'
  mode '0600'
end

execute 'Reconfigure chef server' do
  command 'chef-server-ctl reconfigure'
  action :run
end
