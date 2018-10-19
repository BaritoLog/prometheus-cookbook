#
# Cookbook:: prometheus
# Attributes:: blackbox_exporter
#
# Copyright:: 2018, BaritoLog.

# Blackbox Exporter directory
default["blackbox_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/blackbox_exporter"
default["blackbox_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["blackbox_exporter"]["binary"] = "#{node["blackbox_exporter"]["dir"]}/blackbox_exporter"

# Blackbox Exporter version
default["blackbox_exporter"]["version"] = "0.12.0"
default["blackbox_exporter"]["checksum"] = "c5d8ba7d91101524fa7c3f5e17256d467d44d5e1d243e251fd795e0ab4a83605"
default["blackbox_exporter"]["binary_url"] = "https://github.com/prometheus/blackbox_exporter/releases/download/v#{node['blackbox_exporter']['version']}/blackbox_exporter-#{node['blackbox_exporter']['version']}.linux-amd64.tar.gz"

# Blackbox Exporter flags
default["blackbox_exporter"]["flags"]["config.file"] = "#{node["blackbox_exporter"]["dir"]}/blackbox.yml"