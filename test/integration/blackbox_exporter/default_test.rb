control "blackbox_exporter install" do
  impact 1.0
  title "Tests Prometheus Blackbox Exporter Installation"

  describe file("/opt/prometheus/blackbox_exporter/blackbox_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/blackbox_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("blackbox_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9115) do
    it { should be_listening }
  end
end
