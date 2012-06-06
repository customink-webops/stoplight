#
# Cookbook Name:: stoplight
# Recipe:: apache2
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

include_recipe 'apache2'
include_recipe 'passenger_apache2'

apache_site '000-default' do
  enable false
end

node['stoplight']['servers'].each do |server|
  file = "#{node['apache']['dir']}/sites-available/#{server['name']}"
  template file do
    source 'apache2/site.erb'
    mode 0644
    variables(
      :install_dir => node['stoplight']['install_dir'],
      :server => server,
      :apache => server['apache']
    )
  end

  apache_site server['name'] do
    enable true
  end
end

notifies :reload, 'service[apache2]'
