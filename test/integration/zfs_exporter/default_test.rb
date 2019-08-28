control "zfs_exporter install" do
  impact 1.0
  title "Tests Prometheus Statsd Exporter Installation"

  describe file("/opt/prometheus/zfs_exporter/zfs_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/zfs_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("zfs_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9134) do
    it { should be_listening }
  end
end
