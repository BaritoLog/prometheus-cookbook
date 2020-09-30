#
# Cookbook:: prometheus
# Attributes:: victoriametrics
#
# Copyright:: 2018, BaritoLog.

# victoriametrics directory
default["victoriametrics"]["dir"] = "#{node["prometheus"]["dir"]}/victoriametrics"
default["victoriametrics"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["victoriametrics"]["binary"] = "#{node["victoriametrics"]["dir"]}/victoria-metrics-prod"

# victoriametrics version
default["victoriametrics"]["version"] = "1.42.0"
default["victoriametrics"]["binary_url"] = "https://github.com/VictoriaMetrics/VictoriaMetrics/releases/download/v#{node["victoriametrics"]["version"]}/victoria-metrics-v#{node["victoriametrics"]["version"]}.tar.gz"

# victoriametrics flags
default["victoriametrics"]["flags"] = {
    "storageDataPath": "#{node["victoriametrics"]["dir"]}/data",
    "retentionPeriod": "1"
}