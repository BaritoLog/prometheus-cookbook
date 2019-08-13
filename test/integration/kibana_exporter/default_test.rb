control "kibana_exporter install" do
  impact 1.0
  title "Tests Prometheus Kibana Exporter Installation"

  describe directory("/opt/kibana/current/plugins/kibana-prometheus-exporter/") do
    its("mode") { should cmp "0755" }
  end

  describe directory("/opt/kibana/current/plugins/kibana-prometheus-exporter/") do
    its("owner") {should eq "root" } 
  end

  describe service("kibana") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(5601) do
    it { should be_listening }
  end
end
