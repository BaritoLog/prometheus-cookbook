#
# Cookbook:: prometheus
# Attributes:: alertmanager
#
# Copyright:: 2018, BaritoLog.

# Alertmanager directory
default["alertmanager"]["dir"] = "/opt/prometheus/alertmanager"
default["alertmanager"]["binary"] = "#{node["alertmanager"]["dir"]}/alertmanager"
default["alertmanager"]["log_dir"] = "#{node["prometheus"]["base_log_dir"]}/alertmanager"

# Alertmanager version
default["alertmanager"]["version"] = "0.15.2"
default["alertmanager"]["checksum"] = "79ee23ab2f0444f592051995728ba9e0a7547cc3b9162301e3152dbeaf568d2e"
default["alertmanager"]["binary_url"] = "https://github.com/prometheus/alertmanager/releases/download/v#{node["alertmanager"]["version"]}/alertmanager-#{node["alertmanager"]["version"]}.linux-amd64.tar.gz"

# Alertmanager command-line flags
default["alertmanager"]["flags"]["config.file"] = "#{node["alertmanager"]["dir"]}/alertmanager.yml"

# Alertmanager global configuration
default["alertmanager"]["resolve_timeout"] = "3m"
default["alertmanager"]["templates"] = [
  File.join(node["alertmanager"]["dir"], "/templates/*.yml"),
]
