#
# Cookbook:: prometheus
# Attributes:: promxy
#
# Copyright:: 2018, BaritoLog.

# promxy directory
default["promxy"]["dir"] = "#{node["prometheus"]["dir"]}/promxy"
default["promxy"]["log_dir"] = "#{node["prometheus"]["log_dir"]}"
default["promxy"]["binary"] = "#{node["promxy"]["dir"]}/promxy"

# promxy version
default["promxy"]["version"] = "0.0.60"
default["promxy"]["checksum"] = "f38a01a08ebde01d9faee1c9e0ef352588a1e710821d6d230dbc03d1ab90b02f"
default["promxy"]["binary_url"] = "https://github.com/jacksontj/promxy/releases/download/v#{node["promxy"]["version"]}/promxy-v#{node["promxy"]["version"]}-linux-amd64"
default["promxy"]["config"] = {
    "promxy" => {
        "server_groups" => [
            {
                "static_configs" => [
                    {
                        "target": [
                            "localhost:9090",
                            "localhost:9091"
                        ]
                    }
                ],
                "ignore_error" => true
            }
        ]
    }
}

# promxy flags
default["promxy"]["flags"] = {
    "config": "/opt/prometheus/promxy/config.yaml"
}