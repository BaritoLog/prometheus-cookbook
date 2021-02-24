# blackbox-exporter-wrapper CHANGELOG

This file is used to list changes made in each version of the blackbox-exporter-wrapper cookbook.

## 0.4.2

- Add missing variables on coch.service

## 0.4.1

- Add arguments for coch-log-exporter

## 0.4.0

- Add coch recipe

## 0.3.0

- Add victoriametrics single recipe
  
## 0.2.0

- Add promxy recipe

## 0.1.9

- Remove "app_name" additional labels for pathfinder discovery
  
## 0.1.8

- Exclude barito market app from pathfinder discovery

## 0.1.7

- Add additional labels for pathfinder discovery
  
## 0.1.6

- Add tls support for prometheus remote-write and alerting

## 0.1.5

- Add notify reload on blackbox exporter config change

## 0.1.4

- Add 'ExecReload' entry so systemd blackbox exporter reload command is available

## 0.1.2

- Add default blackbox exporter configuration
- Add privileges to enable ICMP in blackbox exporter using `cap_net_raw`
