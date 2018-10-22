#
# Cookbook:: prometheus
# Attributes:: haproxy_exporter
#
# Copyright:: 2018, BaritoLog.

# Haproxy Exporter directory
default["haproxy_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/haproxy_exporter"
default["haproxy_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["haproxy_exporter"]["binary"] = "#{node["haproxy_exporter"]["dir"]}/haproxy_exporter"

# Haproxy Exporter version
default["haproxy_exporter"]["version"] = "0.9.0"
default["haproxy_exporter"]["checksum"] = "b0d1caaaf245d3d16432de9504575b3af1fec14b2206a468372a80843be001a0"
default["haproxy_exporter"]["binary_url"] = "https://github.com/prometheus/haproxy_exporter/releases/download/v#{node["haproxy_exporter"]["version"]}/haproxy_exporter-#{node["haproxy_exporter"]["version"]}.linux-amd64.tar.gz"

# Haproxy Exporter flags
default["haproxy_exporter"]["flags"]["log.level"] = "info"
