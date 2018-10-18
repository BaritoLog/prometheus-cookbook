control "trickster install" do
  impact 1.0
  title "Tests Prometheus Trickster Installation"

  describe file("/opt/prometheus/trickster/trickster") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/trickster.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("trickster") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9095) do
    it { should be_listening }
    its("processes") { should include "trickster" }
  end

  describe port(9195) do
    it { should be_listening }
    its("processes") { should include "trickster" }
  end
end
