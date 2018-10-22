#
# Cookbook:: prometheus
# Attributes:: statsd_exporter
#
# Copyright:: 2018, BaritoLog.

# Statsd Exporter directory
default["statsd_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/statsd_exporter"
default["statsd_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["statsd_exporter"]["binary"] = "#{node["statsd_exporter"]["dir"]}/statsd_exporter"

# Statsd Exporter version
default["statsd_exporter"]["version"] = "0.8.0"
default["statsd_exporter"]["checksum"] = "0ebd079b0c7f25003fc554957ca76c5941979e70b527a2626d04392b6b9b7715"
default["statsd_exporter"]["binary_url"] = "https://github.com/prometheus/statsd_exporter/releases/download/v#{node["statsd_exporter"]["version"]}/statsd_exporter-#{node["statsd_exporter"]["version"]}.linux-amd64.tar.gz"

# Statsd Exporter config
default["statsd_exporter"]["config"]["defaults"]["timer_type"] = ""
default["statsd_exporter"]["config"]["defaults"]["buckets"] = []
default["statsd_exporter"]["config"]["defaults"]["match_type"] = ""
default["statsd_exporter"]["config"]["defaults"]["glob_disable_ordering"] = false
default["statsd_exporter"]["config"]["mappings"] = []

# Statsd Exporter flags
default["statsd_exporter"]["flags"]["statsd.mapping-config"] = "#{node["statsd_exporter"]["dir"]}/statsd_mapping.yml"
default["statsd_exporter"]["flags"]["log.level"] = "info"
