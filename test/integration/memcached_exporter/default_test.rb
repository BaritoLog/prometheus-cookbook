control "memcached_exporter install" do
  impact 1.0
  title "Tests Prometheus Memcached Exporter Installation"

  describe file("/opt/prometheus/memcached_exporter/memcached_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/memcached_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("memcached_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9150) do
    it { should be_listening }
  end
end
