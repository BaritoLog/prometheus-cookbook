control "fluentd_exporter install" do
  impact 1.0
  title "Tests Prometheus Fluentd Exporter Installation"

  describe file("/opt/prometheus/fluentd_exporter/fluentd_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/fluentd_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("fluentd_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9309) do
    it { should be_listening }
  end
end
