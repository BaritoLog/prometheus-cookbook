control "haproxy_exporter install" do
  impact 1.0
  title "Tests Prometheus Haproxy Exporter Installation"

  describe file("/opt/prometheus/haproxy_exporter/haproxy_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/haproxy_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("haproxy_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9101) do
    it { should be_listening }
  end
end
