#
# Cookbook:: prometheus
# Attributes:: consul_exporter
#
# Copyright:: 2018, BaritoLog.

# Consul Exporter directory
default["consul_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/consul_exporter"
default["consul_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["consul_exporter"]["binary"] = "#{node["consul_exporter"]["dir"]}/consul_exporter"

# Consul Exporter version
default["consul_exporter"]["version"] = "0.4.0"
default["consul_exporter"]["checksum"] = "ff77c03de67cf381f67480b5be6699901785a34145c518c3484ae3e5b8440d08"
default["consul_exporter"]["binary_url"] = "https://github.com/prometheus/consul_exporter/releases/download/v#{node["consul_exporter"]["version"]}/consul_exporter-#{node["consul_exporter"]["version"]}.linux-amd64.tar.gz"

# Consul Exporter flags
default["consul_exporter"]["flags"]["log.level"] = "info"
