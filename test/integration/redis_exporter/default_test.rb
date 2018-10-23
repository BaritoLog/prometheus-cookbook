control "redis_exporter install" do
  impact 1.0
  title "Tests Prometheus Redis Exporter Installation"

  describe file("/opt/prometheus/redis_exporter/redis_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/redis_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("redis_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9121) do
    it { should be_listening }
  end
end
