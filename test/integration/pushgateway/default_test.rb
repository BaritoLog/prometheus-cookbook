control "pushgateway install" do
  impact 1.0
  title "Tests Prometheus Pushgateway Installation"

  describe file("/opt/prometheus/pushgateway/pushgateway") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/pushgateway.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("pushgateway") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9091) do
    it { should be_listening }
    its("processes") { should include "pushgateway" }
  end
end
