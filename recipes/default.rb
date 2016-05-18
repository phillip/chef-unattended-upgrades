#
# Cookbook Name:: unattended-upgrades
# Recipe:: default
#
# Copyright 2012, Phillip Goldenburg
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

package "unattended-upgrades" do
  action :upgrade
end

package "mailutils" do
  action :install
end

template "/etc/apt/apt.conf.d/10periodic" do
  source "10periodic.erb"
  mode "0644"
  owner "root"
  group "root"
  variables(:n => node["unattended_upgrades"])
end

template "/etc/apt/apt.conf.d/50unattended-upgrades" do
  source "50unattended-upgrades.erb"
  mode "0644"
  owner "root"
  group "root"
  variables(:n => node["unattended_upgrades"])
end

execute "unattended-upgrade-periodic" do
  command "unattended-upgrade"
  ignore_failure true
  only_if do
    node['unattended_upgrades']['always_run_unattended_on_exec'] == true ||
    node['unattended_upgrades']['unattended_upgrade_interval'].to_i > 0
  end
end
