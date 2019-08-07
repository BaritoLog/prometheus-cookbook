#
# Cookbook:: prometheus
# Recipe:: pathfinder_discovery
#
# Copyright:: 2019, BaritoLog.

include_recipe 'barito_market::app_install'
include_recipe "prometheus::user"

package 'jq'

# Create directory
directory node["pathfinder_discovery"]["dir"] do
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0755"
  recursive true
end

directory node["pathfinder_discovery"]["log_dir"] do
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0755"
  recursive true
end

#create file based on template
template "#{node["pathfinder_discovery"]["dir"]}/container_parser.rb" do
  source "pathfinder_discovery_container.erb"
  owner node["prometheus"]["user"]
  group node["prometheus"]["group"]
  mode "0644"
end

#create cron
puts node["pathfinder_discovery"]["pathfinder_cluster"]
node["pathfinder_discovery"]["pathfinder_cluster"].each do |cluster_name| 
  node["pathfinder_discovery"]["pathfinder_scrape_type"].each do |key,value| 
    path = key == 'container' ?  node["pathfinder_discovery"]["pathfinder_containers_path"] : node["pathfinder_discovery"]["pathfinder_nodes_path"]
    cron "scheduling-pathfinder-#{key}" do
      minute 5
      user node["prometheus"]["user"]
      command "curl -s '#{node["pathfinder_discovery"]["pathfinder_url"]}#{path}?cluster_name=#{cluster_name}' -H 'X-Auth-Token: #{node["pathfinder_discovery"]["pathfinder_token"]}' | ruby #{node["pathfinder_discovery"]["dir"]}/container_parser.rb | jq '.' > #{node["pathfinder_discovery"]["dir"]}/#{value}"
    end
  end
end

