control "graphite_exporter install" do
  impact 1.0
  title "Tests Prometheus Graphite Exporter Installation"

  describe file("/opt/prometheus/graphite_exporter/graphite_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/graphite_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("graphite_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9109) do
    it { should be_listening }
  end
end
