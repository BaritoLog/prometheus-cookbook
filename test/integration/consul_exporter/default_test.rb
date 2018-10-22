control "consul_exporter install" do
  impact 1.0
  title "Tests Prometheus Consul Exporter Installation"

  describe file("/opt/prometheus/consul_exporter/consul_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/consul_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("consul_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9107) do
    it { should be_listening }
  end
end
