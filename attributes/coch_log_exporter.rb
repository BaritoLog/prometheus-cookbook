default["coch"]["root_dir"] = '/opt/coch-log-exporter'
default["coch"]["dir"] = '/opt/coch-log-exporter/bin'
default["coch"]["binary"] = "#{node["coch"]["dir"]}/coch-log-exporter"
default["coch"]["version"] = "3.1.0"
default["coch"]["checksum"] = "e4401207f5a5c1037c28bb8e92e0b437a328f2cd1d4c3feda8dd9cb4c6b01a27"
default["coch"]["binary_url"] = "https://github.com/ralibi/coch-log-exporter/releases/download/v#{node["coch"]["version"]}/coch-log-exporter_#{node["coch"]["version"]}_Linux_x86_64.tar.gz"

default["coch"]["component_list"] = 'comp1, comp2'
default["coch"]["index_list"] = 'index1, index2'
default["coch"]["source_url"] = 'elastiseach_address'
default["coch"]["labels"] = 'label1, label2, label3'
