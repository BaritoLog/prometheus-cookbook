#
# Cookbook:: prometheus
# Attributes:: lxd_exporter
#
# Copyright:: 2018, BaritoLog.

default["lxd_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/lxd_exporter"
default["lxd_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["lxd_exporter"]["binary"] = "#{node["lxd_exporter"]["dir"]}/lxd_exporter"

default["lxd_exporter"]["version"] = "0.2.0"
default["lxd_exporter"]["checksum"] = "310677ca3a0aae566d4e83ec59c5858024e832b972e65fed6811fe5e7abf0e43"
default["lxd_exporter"]["binary_url"] = "https://github.com/BaritoLog/lxd_exporter/releases/download/v#{node["lxd_exporter"]["version"]}/lxd_exporter-#{node["lxd_exporter"]["version"]}.linux-amd64.tar.xz"

default["lxd_exporter"]["lxd_socket"] = "/var/snap/lxd/common/lxd/unix.socket"

default["lxd_exporter"]["flags"]["port"] = "9142"
