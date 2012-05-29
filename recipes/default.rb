#
# Cookbook Name:: stoplight
# Recipe:: default
#
# Copyright 2012, CustomInk, LLC
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

gem_package 'bundler'

node['stoplight']['servers'].each do |server|
  install_dir = [ node['stoplight']['install_dir'], server['name'] ].join('/')

  execute 'Stop the application server' do
    command "if [ -f #{install_dir}/tmp/server.pid ]; then sudo kill --quiet -9 `cat #{install_dir}/tmp/server.pid`; fi; exit 0"
  end

  execute 'Remove existing Stoplight instance' do
    command "rm -rf #{install_dir}"
  end

  directory install_dir do
    recursive true
  end

  execute 'Clone the Stoplight repository' do
    cwd install_dir
    command 'git clone https://github.com/customink/stoplight.git .'
  end

  execute 'Bundle install application dependencies' do
    cwd install_dir
    command 'bundle install'
  end

  template "#{install_dir}/config/servers.yml" do
    source 'config/servers.yml.erb'
    owner 'root'
    group 'root'
    variables(
      :servers => server['servers']
    )
  end

  %w(log tmp).each do |dir|
    execute "Create the #{dir} directory" do
      cwd install_dir
      command "mkdir ./#{dir}"
    end
  end

  execute 'Launch Stoplight' do
    cwd install_dir
    command "sudo bundle exec rackup #{install_dir}/config.ru --port #{server['port']} --daemonize --pid #{install_dir}/tmp/server.pid"
  end
end
