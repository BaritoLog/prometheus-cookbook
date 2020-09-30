#
# Cookbook:: prometheus
# Recipe:: victoriametrics
#
# Copyright:: 2020, BaritoLog.

include_recipe "prometheus::user"

# Create directory
directory node["victoriametrics"]["dir"] do
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0755"
  recursive true
end

directory node["victoriametrics"]["log_dir"] do
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0755"
  recursive true
end

# Download prometheus victoriametrics binary & unpack
binary_file = node["victoriametrics"]["binary"]
archive_file = "/tmp/victoriametrics-#{node["victoriametrics"]["version"]}.gz"

remote_file archive_file do
  source node["victoriametrics"]["binary_url"]
  notifies :run, "execute[extract-victoriametrics]", :immediately
end

execute "extract-victoriametrics" do
  command "test ! -f '#{binary_file}' || mv '#{binary_file}' '#{binary_file}.bak' && tar zxf #{archive_file} --directory #{node["victoriametrics"]["dir"]} && chmod 755 #{binary_file}"
  user node["prometheus"]["user"]
  group node["prometheus"]["group"]
  action :nothing
  notifies :restart, "service[victoriametrics]", :delayed
end

systemd_unit "victoriametrics.service" do
  content <<~END_UNIT
            [Unit]
            Description=victoriametrics
            After=network.target

            [Service]
            ExecStart=/bin/bash -ce 'exec #{node["victoriametrics"]["binary"]} #{Gitlab::Prometheus.kingpin_flags_for(node, "victoriametrics")} >> "#{node["victoriametrics"]["log_dir"]}/victoriametrics.log" 2>&1'
            User=#{node["prometheus"]["user"]}
            Restart=always
            RestartSec=10

            [Install]
            WantedBy=multi-user.target
          END_UNIT
  action %i(create enable)
  notifies :restart, "service[victoriametrics]", :delayed
end

service "victoriametrics" do
  action %i(enable start)
end