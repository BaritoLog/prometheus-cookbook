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

file "/opt/coch-log-exporter/.cochenv" do
  content <<~END_UNIT
             COCH_LOG_EXPORTER_SOURCE_URL=-source-url=\"http://elasticsearch.service.consul:9200/conformance-checker-*/_search?size=10000\"
             COCH_LOG_EXPORTER_LABELS=-labels=\"namespace_prefix, terraform_module_name, service_name, ansible_role, ansible_role_version, name\"
             COCH_LOG_EXPORTER_INTERVAL=-interval=\"20\"
	     COCH_LOG_EXPORTER_LISTEN_ADDRESS=-listen-address=\":8090\"
             END_UNIT
  mode '0744'
  owner 'root'
  group 'root'
end

systemd_unit "coch.service" do
  content <<~END_UNIT
            [Unit]
            Description=Conformance Checker Elastisearch Exporter
            After=network.target

            [Service]
            EnvironmentFile=-#{node["coch"]["root_dir"]}/.cochenv
            ExecStart=#{node["coch"]["binary"]} \$COCH_LOG_EXPORTER_SOURCE_URL \$COCH_LOG_EXPORTER_LABELS \$COCH_LOG_EXPORTER_INTERVAL \$COCH_LOG_EXPORTER_LISTEN_ADDRESS
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
