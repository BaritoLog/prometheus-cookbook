module Gitlab
  module Prometheus
    def self.kingpin_flags_for(node, service)
      config = ""
      node[service]["flags"].each do |flag_key, flag_value|
        if flag_value == true
          config += "--#{flag_key} "
        elsif flag_value == false
          config += "--no-#{flag_key} "
        else
          config += "--#{flag_key}=#{flag_value} " unless flag_value.empty?
        end
      end
      config
    end

    def self.flags_for(node, service)
      config = ""
      node[service]["flags"].each do |flag_key, flag_value|
        config += "-#{flag_key}=#{flag_value} " unless flag_value.empty?
      end
      config
    end

    class NodeConfiguration
      def initialize(hostname, ip, port, fqdn, is_public, prometheus_labels)
        @hostname =  hostname
        @ip =        ip
        @port =      port
        @fqdn =      fqdn
        @is_public = is_public
        @labels    = prometheus_labels || {}
      end

      def public_address
        "#{@fqdn}:#{@port}"
      end

      def private_address
        "#{@ip}:#{@port}"
      end

      def labels
        lbls = { "fqdn" => @fqdn.to_s }.merge(@labels)
        lbls["instance"] = public_address unless @is_public
        lbls
      end

      def targets
        if @is_public
          [public_address]
        else
          [private_address]
        end
      end

      def to_h
        { "targets" => targets, "labels" => labels }
      end
    end

    def generate_inventory_file(query, port, public_hosts)
      nodes = query.map { |node|
        first_ipv4_address = Gitlab.private_ips_for_node(node).first
        if (first_ipv4_address || "").empty?
          Chef::Log.warn("Node #{node['hostname']} does not have an ipv4 defined")
          next
        end
        prometheus = node["prometheus"] || {}
        NodeConfiguration.new(node["hostname"],
                              first_ipv4_address,
                              port,
                              (node["fqdn"]).to_s,
                              public_hosts.include?(node["fqdn"]),
                              prometheus["labels"])
      }.compact # Why are we compacting here? are we adding nils somehow?

      nodes.inject([]) do |inventory, node|
        inventory << node.to_h
      end
    end

    def hash_to_yaml(hash)
      mutable_hash = JSON.parse(hash.dup.to_json)
      mutable_hash.to_yaml
    end

    def parse_jobs(jobs, inventory_dir)
      jobs.sort.map { |name, job|
        scrape_config = {
          "job_name": name,
        }.merge(job.to_hash)

        # Make sure honor_labels is a bool
        scrape_config["honor_labels"] = job["honor_labels"].to_s == "true" if job["honor_labels"]

        # Convert inventory file to file_sd_configs.
        if job["inventory_file_name"] || job["file_inventory"]
          # Default honor_labels to true since some inventory files override `instance`.
          scrape_config["honor_labels"] = true unless job["honor_labels"]

          file_name = (job["inventory_file_name"] || name) + ".yml"
          scrape_config["file_sd_configs"] = [
            { "files" => [File.join(inventory_dir, file_name)] },
          ]
          scrape_config.delete("inventory_file_name")
          scrape_config.delete("file_inventory")
          scrape_config.delete("role_name")
          scrape_config.delete("chef_search")
          scrape_config.delete("public_hosts")
        end

        # Remove other keys.
        scrape_config.delete("exporter_port")

        scrape_config
      }
    end
  end
end

Chef::Recipe.send(:include, Gitlab::Prometheus)
Chef::Resource.send(:include, Gitlab::Prometheus)
Chef::Provider.send(:include, Gitlab::Prometheus)
