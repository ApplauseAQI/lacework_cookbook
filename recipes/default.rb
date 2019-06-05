#
# Cookbook Name:: lacework
# Recipe:: default
#
# Copyright © 2019 Applause App Quality, Inc.
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

dist = node['platform']
pver =
  if node['platform'] == 'debian'
    node['platform_version'].to_i
  else
    node['platform_version'].to_f
  end

apt_repository 'lacework' do
  uri "https://packages.lacework.net/DEB/#{dist}/#{pver}/"
  arch 'amd64'
  components ['main']
  key '18E76630'
  only_if { node['platform_family'] == 'debian' }
end

yum_repository 'lacework' do
  description 'Lacework repository'
  baseurl 'https://packages.lacework.net/RPMS/x86_64/'
  enabled true
  gpgcheck true
  gpgkey 'https://packages.lacework.net/keys/RPM-GPG-KEY-lacework'
  only_if { node['platform_family'] == 'rhel' || node['platform_family'] == 'amazon' }
end

directory '/var/lib/lacework/config' do
  recursive true
  action :create
end

template '/var/lib/lacework/config/config.json' do
  source 'config.json.erb'
  sensitive true
  action :create
end

ver =
  if platform_family?('rhel', 'amazon')
    "#{node['lacework']['version']}-1"
  else
    node['lacework']['version']
  end
package 'lacework' do
  version ver
  action :install
end
