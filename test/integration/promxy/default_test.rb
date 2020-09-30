control "promxy install" do
  impact 1.0
  title "Tests Prometheus promxy Installation"

  describe file("/opt/prometheus/promxy/promxy") do
    its("mode") { should cmp "0755" }
  end

  describe file("/opt/prometheus/promxy/config.yaml") do
    its("mode") { should cmp "0644" }
  end

  describe file("/etc/systemd/system/promxy.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe file("/opt/prometheus/runbooks/rules/es.yml") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("promxy") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(8082) do
    it { should be_listening }
  end
end
