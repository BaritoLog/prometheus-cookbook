#
# Cookbook:: prometheus
# Attributes:: lxd_exporter
#
# Copyright:: 2018, BaritoLog.

default["lxd_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/lxd_exporter"

default["lxd_exporter"]["version"] = "0.1.1"
default["lxd_exporter"]["checksum"] = "45f5502bc88c8f7c329103faa52bcf3b8c76d44f0a6dd045a791b8aceebddace"
default["lxd_exporter"]["binary_url"] = "https://github.com/BaritoLog/lxd_exporter/releases/download/v#{node["lxd_exporter"]["version"]}/lxd_exporter.linux-amd64.tar.gz"
