#
# Cookbook:: prometheus
# Recipe:: promxy
#
# Copyright:: 2020, BaritoLog.

include_recipe "prometheus::user"
include_recipe "prometheus::config"

# Create directory
directory node["promxy"]["dir"] do
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0755"
  recursive true
end

directory node["promxy"]["log_dir"] do
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0755"
  recursive true
end

remote_file node["promxy"]["binary"] do
  source node["promxy"]["binary_url"]
  checksum node["promxy"]["checksum"]
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode '0755'
  action :create
  notifies :restart, "service[promxy]", :delayed
end

config = YAML::dump(node["promxy"]["config"].to_hash)

file "promxy config" do
  path node["promxy"]["flags"]["config"]
  content config
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0644"
  notifies :restart, "service[promxy]", :delayed
end

systemd_unit "promxy.service" do
  content <<~END_UNIT
            [Unit]
            Description=Prometheus promxy
            After=network.target

            [Service]
            ExecStart=/bin/bash -ce 'exec #{node["promxy"]["binary"]} #{Gitlab::Prometheus.kingpin_flags_for(node, "promxy")} >> "#{node["promxy"]["log_dir"]}/promxy.log" 2>&1'
            User=#{node["prometheus"]["user"]}
            Restart=always
            RestartSec=10

            [Install]
            WantedBy=multi-user.target
          END_UNIT
  action %i(create enable)
  notifies :restart, "service[promxy]", :delayed
end

service "promxy" do
  action %i(enable start)
end

service 'promxy' do
  subscribes :restart, "git[#{node["prometheus"]["dir"]}/#{node["prometheus"]["runbooks"]["repo_name"]}]", :delayed
  only_if { ::File.exist?("/etc/systemd/system/promxy.service") }
end
