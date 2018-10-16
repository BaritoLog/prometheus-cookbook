#
# Cookbook:: prometheus
# Recipe:: prometheus
#
# Copyright:: 2018, BaritoLog.

require "yaml"

include_recipe "prometheus::user"

directory node["prometheus"]["log_dir"] do
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0755"
  recursive true
end

# Download prometheus binary & unpack
ark ::File.basename(node["prometheus"]["dir"]) do
  url node["prometheus"]["binary_url"]
  checksum node["prometheus"]["checksum"]
  version node["prometheus"]["version"]
  prefix_root Chef::Config["file_cache_path"]
  path ::File.dirname(node["prometheus"]["dir"])
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  action :put
  notifies :restart, "service[prometheus]", :delayed
end

# Copy configuration from different repository
directory "#{node["prometheus"]["dir"]}/runbooks" do
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0755"
  recursive true
end

git "#{node["prometheus"]["dir"]}/runbooks" do
  repository node["prometheus"]["runbooks"]["git_http"]
  revision node["prometheus"]["runbooks"]["branch"]
  action :sync
  notifies :restart, "service[prometheus]", :delayed
end

link node["prometheus"]["alerting_rules_dir"] do
  to "#{node["prometheus"]["dir"]}/runbooks/alerts"
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
end

link node["prometheus"]["recording_rules_dir"] do
  to "#{node["prometheus"]["dir"]}/runbooks/recordings"
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
end

link node["prometheus"]["rules_dir"] do
  to "#{node["prometheus"]["dir"]}/runbooks/rules"
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
end

directory node["prometheus"]["inventory_dir"] do
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0755"
  recursive true
end

config = {
  "global" => {
    "scrape_interval" => node["prometheus"]["scrape_interval"],
    "scrape_timeout" => node["prometheus"]["scrape_timeout"],
    "evaluation_interval" => node["prometheus"]["evaluation_interval"],
    "external_labels" => node["prometheus"]["external_labels"],
  },
  "rule_files" => node["prometheus"]["rule_files"],
  "alerting" => {
    "alertmanagers" => [
      {
        "file_sd_configs" => [
          {
            "files" => [node["prometheus"]["alertmanager"]["inventory"]],
          },
        ],
      },
    ],
  },
  "scrape_configs" => parse_jobs(node["prometheus"]["jobs"], node["prometheus"]["inventory_dir"]),
}

file "Prometheus config" do
  path node["prometheus"]["flags"]["config.file"]
  content hash_to_yaml(config)
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0644"
  notifies :restart, "service[prometheus]"
end

# Generate job inventory files.
node["prometheus"]["jobs"].each do |name, conf|
  public_hosts = conf["public_hosts"] || []
  exporter_port = conf["exporter_port"] || 80

  search_query = nil
  search_query = [conf["role_name"]].flatten.map { |role_name| "roles:#{role_name}" }.join(" OR ") if conf["role_name"]
  search_query = conf["chef_search"] if conf["chef_search"]
  next if search_query.nil?

  query = search(:node, search_query).sort! { |a, b| a[:fqdn] <=> b[:fqdn] }

  inventory_filepath = File.join(node["prometheus"]["inventory_dir"], "#{conf["inventory_file_name"] || name}.yml")

  file inventory_filepath do
    content generate_inventory_file(query, exporter_port, public_hosts).to_yaml
    owner node["prometheus"]["user"]
    group node["prometheus"]["group"]
    mode "0644"
  end
end

systemd_unit "prometheus.service" do
  content <<~END_UNIT
            [Unit]
            Description=Prometheus Server
            After=network.target

            [Service]
            ExecStart=/bin/bash -ce 'exec #{node["prometheus"]["binary"]} #{Gitlab::Prometheus.kingpin_flags_for(node, "prometheus")} >> "#{node["prometheus"]["log_dir"]}/prometheus.log" 2>&1'
            User=#{node["prometheus"]["user"]}

            [Install]
            WantedBy=multi-user.target
          END_UNIT
  action %i(create enable)
  notifies :restart, "service[prometheus]", :delayed
end

service "prometheus" do
  action %i(enable start)
end
