#
# Cookbook Name:: chef-platform_chefserver
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#include_recipe 'platform_base::apt_config'

execute 'Do system update' do
  command 'apt-get update'
  action :run
end

remote_file '/tmp/chef_server.deb' do
  owner 'root'
  group 'root'
  mode '0644'
  source 'https://packages.chef.io/stable/ubuntu/12.04/chef-server_11.1.7-1_amd64.deb'
end

dpkg_package 'chef_server' do
  action :install
  source '/tmp/chef_server.deb'
end

execute 'Reconfigure chef' do
  command 'chef-server-ctl reconfigure'
  action :run
end

cookbook_file '/etc/chef-server/chef-server.rb' do
  source 'chef-server.rb'
  owner 'root'
  group 'root'
  mode '0644'
end

execute 'Reconfigure chef server' do
  command 'chef-server-ctl reconfigure'
  action :run
end

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
end

execute 'Reconfigure chef' do
  command 'chef-server-ctl restart'
  action :run
end
