require 'serverspec'
require 'pathname'
require 'busser'

set :backend, :exec

# Use Chef's gems to speed things up
chef_gem_path = Dir.glob('/opt/chef/embedded/lib/ruby/gems/*')
chef_gem_path.each do |path|
  gemdirs = Dir.glob("#{path}/gems/*")
  gemdirs = gemdirs.map { |x| x + '/lib' }
  $LOAD_PATH.push(*gemdirs)
end

require 'ohai'

# Setup proper path for sudo environment
path = ENV['PATH'].split(':')
['/sbin', '/usr/sbin', '/usr/local/sbin'].each do |dir|
  !path.include?(dir) && path.insert(0, dir)
end
ENV['PATH'] = path.join(':')
