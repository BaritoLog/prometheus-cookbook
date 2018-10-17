control "alertmanager install" do
  impact 1.0
  title "Tests Prometheus Alertmanager Installation"

  describe file("/opt/prometheus/alertmanager/alertmanager") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/alertmanager.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("alertmanager") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9093) do
    it { should be_listening }
    its("processes") { should include "alertmanager" }
  end
end
