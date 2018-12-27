#!/usr/bin/env bash
# following installation guide on
# - https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html
# - https://www.elastic.co/guide/en/kibana/current/deb.html

# update apt
sudo apt-get update

# install java
sudo apt-get install openjdk-8-jre-headless -y

# install elasticsearch and kibana
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list
sudo apt-get update
sudo apt-get install elasticsearch
sudo apt-get install kibana

# start elasticsearch and kibana on boot
# note that Ubuntu 16.04 uses systemd
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl enable kibana.service

# allow host OS to access through port forwarding
sudo echo "
network.bind_host: 0
network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml
sudo sed -i -e '$a\' /etc/elasticsearch/elasticsearch.yml
sudo sed -i -e '$a\' /etc/elasticsearch/elasticsearch.yml
sudo echo "server.host: \"0.0.0.0\"" >> /etc/kibana/kibana.yml

# start the services
sudo service kibana start
sudo service elasticsearch start
