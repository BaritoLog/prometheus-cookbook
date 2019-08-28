#
# Cookbook:: prometheus
# Attributes:: zfs_exporter
#
# Copyright:: 2018, BaritoLog.

# Statsd Exporter directory
default["zfs_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/zfs_exporter"
default["zfs_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["zfs_exporter"]["binary"] = "#{node["zfs_exporter"]["dir"]}/zfs_exporter"

# Statsd Exporter version
default["zfs_exporter"]["version"] = "0.0.3"
default["zfs_exporter"]["checksum"] = "9976810ae7a0e3593d6727d46d8c45a23f534e5794de816ed8309a42bb86cb34"
default["zfs_exporter"]["binary_url"] = "https://github.com/pdf/zfs_exporter/releases/download/v#{node["statsd_exporter"]["version"]}/statsd_exporter-#{node["statsd_exporter"]["version"]}.linux-amd64.tar.gz"
