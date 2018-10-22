#
# Cookbook:: prometheus
# Attributes:: pushgateway
#
# Copyright:: 2018, BaritoLog.

# Pushgateway directory
default["pushgateway"]["dir"] = "#{node["prometheus"]["dir"]}/pushgateway"
default["pushgateway"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["pushgateway"]["binary"] = "#{node["pushgateway"]["dir"]}/pushgateway"

# Pushgateway version
default["pushgateway"]["version"] = "0.5.2"
default["pushgateway"]["checksum"] = "d4aeb15b9667bae79170d4f12b4afa20dc29850aeac2ce071479d93057fb5c3b"
default["pushgateway"]["binary_url"] = "https://github.com/prometheus/pushgateway/releases/download/v#{node["pushgateway"]["version"]}/pushgateway-#{node["pushgateway"]["version"]}.linux-amd64.tar.gz"

# Pushgateway flags
default["pushgateway"]["flags"]["persistence.file"] = ""
