#!/bin/bash
set -e

# Mise à jour du système
sudo apt update -y
sudo apt upgrade -y

# Installation des prérequis
sudo apt install -y wget curl gnupg software-properties-common

# Installation de Java
sudo apt install -y openjdk-11-jre-headless

# Importer les clés GPG Elastic
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg
sudo apt-get install apt-transport-https

# Installer Elasticsearch
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${elasticsearch_version}-amd64.deb
sudo dpkg -i elasticsearch-${elasticsearch_version}-amd64.deb
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

# Installer Kibana
wget https://artifacts.elastic.co/downloads/kibana/kibana-${kibana_version}-amd64.deb
sudo dpkg -i kibana-${kibana_version}-amd64.deb
sudo systemctl enable kibana
sudo systemctl start kibana

# Installer Heartbeat
wget https://artifacts.elastic.co/downloads/beats/heartbeat/heartbeat-${heartbeat_version}-amd64.deb
sudo dpkg -i heartbeat-${heartbeat_version}-amd64.deb
sudo systemctl enable heartbeat
sudo systemctl start heartbeat

# Nettoyer les fichiers d'installation
rm elasticsearch-${elasticsearch_version}-amd64.deb
rm kibana-${kibana_version}-amd64.deb
rm heartbeat-${heartbeat_version}-amd64.deb

echo "Elastic Stack installation completed successfully!"