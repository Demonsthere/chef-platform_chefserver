execute 'Do system update' do
  command 'apt-get update'
  action :run
end

remote_file '/tmp/chef_server.deb' do
  owner 'root'
  group 'root'
  mode '0644'
  source node['platform_chefserver']['chef_url']
end

dpkg_package 'chef_server' do
  action :install
  source '/tmp/chef_server.deb'
end

execute 'Reconfigure chef' do
  command 'chef-server-ctl reconfigure'
  action :run
end
