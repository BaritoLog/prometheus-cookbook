control "victoriametrics install" do
  impact 1.0
  title "Tests Prometheus victoriametrics Installation"

  describe file("/opt/prometheus/victoriametrics/victoriametrics") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/victoriametrics.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("victoriametrics") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8428) do
    it { should be_listening }
  end
end
