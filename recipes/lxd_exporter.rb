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
