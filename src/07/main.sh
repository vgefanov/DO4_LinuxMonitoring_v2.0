#!/bin/bash

#install node_exporter (http://localhost:9100)
export VERSION="1.5.0"
wget https://github.com/prometheus/node_exporter/releases/download/v$VERSION/node_exporter-$VERSION.linux-amd64.tar.gz -O - | tar -xzv -C ./
cd node_exporter-$VERSION.linux-amd64
./node_exporter

#install prometheus (http://localhost:9090)
sudo apt install prometheus
systemctl start prometheus
systemctl status prometheus

#install grafana (http://localhost:3000)
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_9.3.2_amd64.deb
sudo dpkg -i grafana_9.3.2_amd64.deb
systemctl start grafana-server
systemctl status grafana-server

#grafana dashboard metrics
#отображение ЦПУ - process_cpu_seconds_total
#доступная оперативная память - node_memory_MemAvailable_bytes
#свободное место - node_memory_MemFree_bytes
#кол-во операций ввода/вывода на жестком диске - node_disk_io_now

#stress utility
sudo apt install stress
stress -c 2 -i 1 -m 1 --vm-bytes 32M -t 10s
