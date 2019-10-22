control "lxd_exporter install" do
  impact 1.0
  title "Tests Prometheus LXD Exporter Installation"

  describe file("/opt/prometheus/lxd_exporter/lxd_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe service("lxd_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9142) do
    it { should be_listening }
  end
end
