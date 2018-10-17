#
# Cookbook:: prometheus
# Attributes:: pushgateway
#
# Copyright:: 2018, BaritoLog.

# Pushgateway directory
default["pushgateway"]["dir"] = "/opt/prometheus/pushgateway"
default["pushgateway"]["binary"] = "#{node["pushgateway"]["dir"]}/pushgateway"
default["pushgateway"]["log_dir"] = "#{node["prometheus"]["base_log_dir"]}/pushgateway"

# Pushgateway version
default["pushgateway"]["version"] = "0.5.2"
default["pushgateway"]["checksum"] = "d4aeb15b9667bae79170d4f12b4afa20dc29850aeac2ce071479d93057fb5c3b"
default["pushgateway"]["binary_url"] = "https://github.com/prometheus/pushgateway/releases/download/v#{node['pushgateway']['version']}/pushgateway-#{node['pushgateway']['version']}.linux-amd64.tar.gz"