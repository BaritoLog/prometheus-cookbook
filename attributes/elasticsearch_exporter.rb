#
# Cookbook:: prometheus
# Attributes:: elasticsearch_exporter
#
# Copyright:: 2018, BaritoLog.

# Elasticsearch Exporter directory
default["elasticsearch_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/elasticsearch_exporter"
default["elasticsearch_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["elasticsearch_exporter"]["binary"] = "#{node["elasticsearch_exporter"]["dir"]}/elasticsearch_exporter"

# Elasticsearch Exporter version
default["elasticsearch_exporter"]["version"] = "1.0.2"
default["elasticsearch_exporter"]["checksum"] = "9f1a35e4acf93bc073ba0106578fa9762ed09af4e89485063ca3a93a9d0201b8"
default["elasticsearch_exporter"]["binary_url"] = "https://github.com/justwatchcom/elasticsearch_exporter/releases/download/v#{node["elasticsearch_exporter"]["version"]}/elasticsearch_exporter-#{node["elasticsearch_exporter"]["version"]}.linux-amd64.tar.gz"

# Elasticsearch Exporter flags
default["elasticsearch_exporter"]["flags"]["es.timeout"] = "5s"
