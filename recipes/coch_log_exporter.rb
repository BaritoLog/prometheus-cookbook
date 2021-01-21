#
# Cookbook:: coch-log-setup
# Recipe:: default
# Maintain-by:: @irwanshofwan & @ralibi
#
# Copyright:: 2021, The Authors, All Rights Reserved.

directory node["coch"]["dir"] do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
end

# Download coch-elasticsearch-exporterbinary & unpack
ark ::File.basename(node["coch"]["dir"]) do
  url node["coch"]["binary_url"]
  checksum node["coch"]["checksum"]
  version node["coch"]["version"]
  prefix_root Chef::Config["file_cache_path"]
  path ::File.dirname(node["coch"]["dir"])
  strip_components 0
  owner 'root'
  group 'root'
  action :put
  notifies :restart, "service[coch]", :delayed
end

systemd_unit "coch.service" do
  content <<~END_UNIT
            [Unit]
            Description=Conformance Checker Elastisearch Exporter
            After=network.target

            [Service]
            ExecStart=/bin/bash #{node["coch"]["binary"]}
            Restart=on-failure

            [Install]
            WantedBy=default.target
            WantedBy=multi-user.target
            END_UNIT
  action %i(create enable)
  notifies :restart, "service[coch]", :delayed
end

service "coch" do
  action %i(enable start)
end
