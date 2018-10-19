control "node_exporter install" do
  impact 1.0
  title "Tests Prometheus Node Exporter Installation"

  describe file("/opt/prometheus/node_exporter/node_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/node_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("node_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9100) do
    it { should be_listening }
  end
end
