default["coch"]["dir"] = '/opt/conformance-checker-elasticalert-exporter'
default["coch"]["binary"] = "#{node["coch"]["dir"]}/bin"
default["coch"]["version"] = "0.1.0"
default["coch"]["checksum"] = "dfb7529bc38658ed3c682ef3d55012c475acadf3f2793906bbf5dd9624188cac"
default["coch"]["binary_url"] = "https://github.com/ralibi/coch-log-exporter/releases/download/v#{node["coch"]["version"]}/coch-log-exporter_#{node["coch"]["version"]}_Linux_x86_64.tar.gz"
