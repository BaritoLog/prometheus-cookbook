#
# Cookbook:: prometheus
# Recipe:: kibana_exporter
#
# Copyright:: 2019, BaritoLog.

include_recipe "prometheus::user"

ark ::File.basename(node["lxd_exporter"]["dir"]) do
  url node["lxd_exporter"]["binary_url"]
  checksum node["lxd_exporter"]["checksum"]
  version node["lxd_exporter"]["version"]
  prefix_root Chef::Config["file_cache_path"]
  path ::File.dirname(node["lxd_exporter"]["dir"])
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  action :put
end

systemd_unit "lxd_exporter.service" do
  content <<~END_UNIT
            [Unit]
            Description=Prometheus LXD Exporter
            After=network.target

            [Service]
            ExecStart=/bin/bash -ce 'exec #{node["lxd_exporter"]["binary"]} >> "#{node["lxd_exporter"]["log_dir"]}/lxd_exporter.log" 2>&1'
            User=#{node["prometheus"]["user"]}
            Restart=always

            [Install]
            WantedBy=multi-user.target
          END_UNIT
  action %i(create enable)
end
