control "mysqld_exporter install" do
  impact 1.0
  title "Tests Prometheus Mysqld Exporter Installation"

  describe file("/opt/prometheus/mysqld_exporter/mysqld_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/mysqld_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("mysqld_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9104) do
    it { should be_listening }
  end
end
