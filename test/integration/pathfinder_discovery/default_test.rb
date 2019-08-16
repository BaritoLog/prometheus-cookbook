control "pathfinder_discovery setup" do
    impact 1.0
    title "Tests Prometheus Pathfinder Disovery Setup"
  
    describe file("/opt/prometheus/pathfinder_discovery/container_parser.rb") do
      its("mode") { should cmp "0644" }
    end
  
    describe crontab("prometheus") do
        its('minutes') { should cmp ['*/5', '*/5']}
    end
  end
  