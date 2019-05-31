#!/bin/bash
###############################################################################################################
# This script performs the following tasks:
# 1) Download and execute the node exporter and push the logs to file
###############################################################################################################

node_exporter_version=0.18.0
wget https://github.com/prometheus/node_exporter/releases/download/v$node_exporter_version/node_exporter-$node_exporter_version.linux-amd64.tar.gz
tar xvfz node_exporter-$node_exporter_version.linux-amd64.tar.gz
cd  node_exporter-$node_exporter_version.linux-amd64
nohup ./node_exporter >> ./node_exporter.log &
