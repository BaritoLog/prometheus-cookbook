control "lxd_exporter install" do
  impact 1.0
  title "Tests Prometheus LXD Exporter Installation"

  describe file("/opt/prometheus/lxd_exporter/lxd_exporter") do
    its("mode") { should cmp "0755" }
  end
end
