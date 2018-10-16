control "prometheus install" do
  impact 1.0
  title "Tests Prometheus Installation"

  describe file("/opt/prometheus/prometheus/prometheus") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/prometheus.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("prometheus") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9090) do
    it { should be_listening }
    its("processes") { should include "prometheus" }
  end
end
