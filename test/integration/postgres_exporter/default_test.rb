control "postgres_exporter install" do
  impact 1.0
  title "Tests Prometheus Postgres Exporter Installation"

  describe file("/opt/prometheus/postgres_exporter/postgres_exporter") do
    its("mode") { should cmp "0775" }
  end

  describe file("/etc/systemd/system/postgres_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("postgres_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9187) do
    it { should be_listening }
  end
end
