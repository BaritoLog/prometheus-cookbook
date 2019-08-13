#
# Cookbook:: prometheus
# Recipe:: kibana_exporter
#
# Copyright:: 2019, BaritoLog.

execute 'plugin-install' do
  cwd node["kibana_exporter"]["kibana_base_dir"]
  command "bin/kibana-plugin install #{node["kibana_exporter"]["url"]}"
end