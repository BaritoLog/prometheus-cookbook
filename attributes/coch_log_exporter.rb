default["coch"]["root_dir"] = '/opt/coch-log-exporter'
default["coch"]["dir"] = '/opt/coch-log-exporter/bin'
default["coch"]["binary"] = "#{node["coch"]["dir"]}/coch-log-exporter"
default["coch"]["version"] = "0.1.1"
default["coch"]["checksum"] = "3c3fe9a368a579ba9996018ab9ef164d86c8817833999e7b8b10ad0a5520d0e1"
default["coch"]["binary_url"] = "https://github.com/ralibi/coch-log-exporter/releases/download/v#{node["coch"]["version"]}/coch-log-exporter_#{node["coch"]["version"]}_Linux_x86_64.tar.gz"
