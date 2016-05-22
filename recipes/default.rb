#
# Cookbook Name:: platform_chefserver
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'platform_chefserver::_install_chef_server'
include_recipe 'platform_chefserver::_customize_chef_server'
include_recipe 'platform_chefserver::_load_cookbooks'

execute 'Restart chef' do
  command 'chef-server-ctl restart'
  action :run
end
