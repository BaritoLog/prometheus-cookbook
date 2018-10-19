#
# Cookbook:: prometheus
# Attributes:: node_exporter
#
# Copyright:: 2018, BaritoLog.

# Node Exporter directory
default["node_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/node_exporter"
default["node_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["node_exporter"]["binary"] = "#{node["node_exporter"]["dir"]}/node_exporter"

# Node Exporter version
default["node_exporter"]["version"] = "0.16.0"
default["node_exporter"]["checksum"] = "e92a601a5ef4f77cce967266b488a978711dabc527a720bea26505cba426c029"
default["node_exporter"]["binary_url"] = "https://github.com/prometheus/node_exporter/releases/download/v#{node["node_exporter"]["version"]}/node_exporter-#{node["node_exporter"]["version"]}.linux-amd64.tar.gz"

# Node Exporter flags
default["node_exporter"]["flags"]["collector.textfile.directory"] = ""
