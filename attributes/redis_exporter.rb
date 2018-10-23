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
default["redis_exporter"]["version"] = "0.21.2"
default["redis_exporter"]["checksum"] = "f4985b2b292390099e9a8c63c4867c78cc08bdbcfc522aa86b01358653419400"
default["redis_exporter"]["binary_url"] = "https://github.com/oliver006/redis_exporter/releases/download/v#{node["redis_exporter"]["version"]}/redis_exporter-v#{node["redis_exporter"]["version"]}.linux-amd64.tar.gz"

# Redis Exporter flags
default["redis_exporter"]["flags"]["log-format"] = "txt"
