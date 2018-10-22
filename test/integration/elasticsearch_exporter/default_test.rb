control "elasticsearch_exporter install" do
  impact 1.0
  title "Tests Prometheus Elasticsearch Exporter Installation"

  describe file("/opt/prometheus/elasticsearch_exporter/elasticsearch_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/elasticsearch_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("elasticsearch_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9108) do
    it { should be_listening }
  end
end
