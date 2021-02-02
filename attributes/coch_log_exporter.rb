default["coch"]["root_dir"] = '/opt/coch-log-exporter'
default["coch"]["dir"] = '/opt/coch-log-exporter/bin'
default["coch"]["binary"] = "#{node["coch"]["dir"]}/coch-log-exporter"
default["coch"]["version"] = "0.2.0"
default["coch"]["checksum"] = "ad40becb71a2c0117ca1f9a375c6c29e2ae5ac99428ce3870a20ccbbff160f07"
default["coch"]["binary_url"] = "https://github.com/ralibi/coch-log-exporter/releases/download/v#{node["coch"]["version"]}/coch-log-exporter_#{node["coch"]["version"]}_Linux_x86_64.tar.gz"
