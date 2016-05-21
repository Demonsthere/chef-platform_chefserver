require_relative '../spec_helper'

# ----------------------------
# chefserver specs
# ----------------------------#

['chef', 'chef-server'].each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe process('nginx') do
  it { should be_running }
end

describe user('chef_server') do
  it { should exist }
end

describe file('/etc/chef-server/chef-server.rb') do
  it { should exist }
end

describe file('/etc/chef-server/chef-server-running.json') do
  it { should contain '"ssl_port": 4243' }
end

describe file('/var/opt/chef-server/bookshelf') do
  it { should exist }
  it { should be_symlink }
  it { should be_owned_by 'chef_server' }
  it { should be_linked_to '/var/cookbooks/bookshelf' }
end
