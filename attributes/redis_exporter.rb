#
# Cookbook:: prometheus
# Attributes:: redis_exporter
#
# Copyright:: 2018, BaritoLog.

# Redis Exporter directory
default["redis_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/redis_exporter"
default["redis_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["redis_exporter"]["binary"] = "#{node["redis_exporter"]["dir"]}/redis_exporter"

# Redis Exporter version
default["redis_exporter"]["version"] = "1.0.3"
default["redis_exporter"]["checksum"] = "cb5d428485d35bcc04286a81f94a937f294450fa9c040a1dc628f6a168034b5b"
default["redis_exporter"]["binary_url"] = "https://github.com/oliver006/redis_exporter/releases/download/v#{node["redis_exporter"]["version"]}/redis_exporter-v#{node["redis_exporter"]["version"]}.linux-amd64.tar.gz"

# Redis Exporter flags
default["redis_exporter"]["flags"]["log-format"] = "txt"
