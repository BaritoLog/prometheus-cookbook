#
# Cookbook:: prometheus
# Attributes:: postgres_exporter
#
# Copyright:: 2018, BaritoLog.

# Postgres Exporter directory
default["postgres_exporter"]["dir"] = "#{node["prometheus"]["dir"]}/postgres_exporter"
default["postgres_exporter"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["postgres_exporter"]["binary"] = "#{node["postgres_exporter"]["dir"]}/postgres_exporter"

# Postgres Exporter version
default["postgres_exporter"]["version"] = "0.4.6"
default["postgres_exporter"]["checksum"] = "9ed457c9a6d3a1e0132b3fe10f1d072457a667b009993a73e90b47ca99cc5bca"
default["postgres_exporter"]["binary_url"] = "https://github.com/wrouesnel/postgres_exporter/releases/download/v#{node["postgres_exporter"]["version"]}/postgres_exporter_v#{node["postgres_exporter"]["version"]}_linux-amd64.tar.gz"

# Postgres Exporter config
default["postgres_exporter"]["config"]["postgres_dsn"] = "postgresql://postgres:password@localhost:5432/?sslmode=disable"

# Postgres Exporter flags
default["postgres_exporter"]["flags"]["log.level"] = "info"
