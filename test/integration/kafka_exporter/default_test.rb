control "kafka_exporter install" do
  impact 1.0
  title "Tests Prometheus Kafka Exporter Installation"

  describe file("/opt/prometheus/kafka_exporter/kafka_exporter") do
    its("mode") { should cmp "0755" }
  end

  describe file("/etc/systemd/system/kafka_exporter.service") do
    its("owner") do
      should eq "root"
    end
    its("mode") { should cmp "0644" }
  end

  describe service("kafka_exporter") do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(9308) do
    it { should be_listening }
  end
end
