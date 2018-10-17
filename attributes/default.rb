#
# Cookbook:: prometheus
# Attributes:: default
#
# Copyright:: 2018, BaritoLog.

# Prometheus user
default["prometheus"]["user"] = "prometheus"
default["prometheus"]["group"] = "prometheus"

# Prometheus version
default["prometheus"]["version"] = "2.4.3"
default["prometheus"]["checksum"] = "3aa063498ab3b4d1bee103d80098ba33d02b3fed63cb46e47e1d16290356db8a"
default["prometheus"]["binary_url"] = "https://github.com/prometheus/prometheus/releases/download/v#{node["prometheus"]["version"]}/prometheus-#{node["prometheus"]["version"]}.linux-amd64.tar.gz"

# Prometheus configuratio repository
default["prometheus"]["runbooks"]["git_http"] = "https://ops.gitlab.net/gitlab-com/runbooks.git"
default["prometheus"]["runbooks"]["branch"] = "master"

# Prometheus directory configuration
default["prometheus"]["dir"] = "/opt/prometheus/prometheus"
default["prometheus"]["binary"] = "#{node["prometheus"]["dir"]}/prometheus"
default["prometheus"]["alerting_rules_dir"] = "#{node["prometheus"]["dir"]}/alerts"
default["prometheus"]["recording_rules_dir"] = "#{node["prometheus"]["dir"]}/recordings"
default["prometheus"]["rules_dir"] = "#{node["prometheus"]["dir"]}/rules"
default["prometheus"]["console_templates_dir"] = "#{node["prometheus"]["dir"]}/consoles"
default["prometheus"]["inventory_dir"] = "#{node["prometheus"]["dir"]}/inventory"
default["prometheus"]["base_log_dir"] = "/var/log/prometheus"
default["prometheus"]["log_dir"] = "#{node["prometheus"]["base_log_dir"]}/prometheus"

# Prometheus global configuration
default["prometheus"]["scrape_interval"] = "15s"
default["prometheus"]["scrape_timeout"] = "10s"
default["prometheus"]["evaluation_interval"] = "15s"
default["prometheus"]["external_labels"] = {}

# Prometheus command-line flags
default["prometheus"]["flags"]["config.file"] = "#{node["prometheus"]["dir"]}/prometheus.yml"
default["prometheus"]["flags"]["web.console.libraries"] = "#{node["prometheus"]["dir"]}/console_libraries"
default["prometheus"]["flags"]["web.console.templates"] = "#{node["prometheus"]["dir"]}/consoles"
default["prometheus"]["flags"]["web.enable-admin-api"] = true
default["prometheus"]["flags"]["web.enable-lifecycle"] = true
default["prometheus"]["flags"]["web.external-url"] = "https://#{node["fqdn"]}"

# Prometheus command-line flags for storage
default["prometheus"]["flags"]["storage.tsdb.path"] = "#{node["prometheus"]["dir"]}/data"
default["prometheus"]["flags"]["storage.tsdb.retention"] = "365d"
default["prometheus"]["flags"]["storage.tsdb.max-block-duration"] = "7d"
default["prometheus"]["rule_files"] = [
  File.join(node["prometheus"]["alerting_rules_dir"], "/*.yml"),
  File.join(node["prometheus"]["recording_rules_dir"], "/*.yml"),
  File.join(node["prometheus"]["rules_dir"], "/*.yml"),
]

# Prometheus alerting & job configuration
default["prometheus"]["alerting"] = []
default["prometheus"]["jobs"] = []
