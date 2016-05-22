execute 'Stop chef server' do
  command 'chef-server-ctl stop'
  action :run
end

directory '/var/opt/chef-server/bookshelf' do
  action :delete
  recursive true
end

link '/var/opt/chef-server/bookshelf' do
  to '/var/cookbooks/bookshelf'
  link_type :symbolic
  owner 'chef_server'
  group 'chef_server'
end

directory '/var/opt/chef-server/bookshelf' do
  owner 'chef_server'
  group 'chef_server'
  action :create
  recursive true
  mode '777'
end
