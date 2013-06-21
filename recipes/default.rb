#
# Cookbook Name:: stoplight
# Recipe:: default
#
# Copyright 2012-2013, Seth Vargo (sethvargo@gmail.com)
# Copyright 2012-2013, CustomInk, LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'git'
include_recipe 'passenger_apache2'
include_recipe 'passenger_apache2::mod_rails'

gem_package 'bundler'

apache_site '000-default' do
  enable false
end

node['stoplight']['servers'].each do |server|
  server_dir = [ node['stoplight']['install_dir'], server['name'] ].join('/')

  directory server_dir do
    recursive true
    owner node['apache']['user']
    group node['apache']['group']
  end

  git server_dir do
    repository node['stoplight']['repo']
    reference node['stoplight']['revision']
    enable_submodules true
    user node['apache']['user']
    group node['apache']['group']
    action :sync
  end

  execute 'Bundle install application dependencies' do
    cwd server_dir
    command 'bundle install'
  end

  template "#{server_dir}/config/servers.yml" do
    source 'config/servers.yml.erb'
    owner node['apache']['user']
    group node['apache']['group']
    variables(
      :servers => server['servers']
    )
  end

  template "#{node['apache']['dir']}/sites-available/#{server['name']}" do
    source 'apache2/site.erb'
    mode 0644
    variables(
      :server_dir => server_dir,
      :server => server
    )
    notifies :reload, 'service[apache2]'
  end

  apache_site server['name'] do
    enable true
  end

  execute 'Restart passenger' do
    cwd server_dir
    command 'touch tmp/restart.txt'
    action :nothing
  end
end
