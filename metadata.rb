name 'prometheus'
maintainer 'GO-JEK Engineering'
maintainer_email 'baritolog@go-jek.com'
license 'Apache-2.0'
description 'Installs/Configures prometheus'
long_description 'Installs/Configures prometheus'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

issues_url 'https://github.com/BaritoLog/prometheus-cookbook/issues'
source_url 'https://github.com/BaritoLog/prometheus-cookbook'

depends "ark", "~> 3.1"