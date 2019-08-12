control "zookeeper_exporter install" do
  impact 1.0
  title "Tests Prometheus Zookeeper Exporter Installation"

  describe file("/opt/prometheus/zookeeper_exporter/zookeeper_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/zookeeper_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("zookeeper_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9141) do
    it { should be_listening }
  end
end
