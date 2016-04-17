#!/usr/bin/env bash

# update apt
sudo apt-get update

# install java
sudo apt-get install openjdk-7-jre-headless -y

# install elasticsearch
wget https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.3.1/elasticsearch-2.3.1.deb
sudo dpkg -i elasticsearch-2.3.1.deb

# start elasticsearch on boot
sudo update-rc.d elasticsearch defaults 95 10

# allow host OS to access through port forwarding
sudo echo "network.bind_host: 0" >> /etc/elasticsearch/elasticsearch.yml
sudo echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml
sudo sed -i -e '$a\' /etc/elasticsearch/elasticsearch.yml
sudo sed -i -e '$a\' /etc/elasticsearch/elasticsearch.yml

# install Kibana
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb http://packages.elastic.co/kibana/4.5/debian stable main" | sudo tee -a /etc/apt/sources.list
sudo apt-get update && sudo apt-get install kibana
sudo update-rc.d kibana defaults 95 10

# install head
sudo /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head

# install marvel
sudo /usr/share/elasticsearch/bin/plugin install license
sudo /usr/share/elasticsearch/bin/plugin install marvel-agent

# install watcher
sudo /usr/share/elasticsearch/bin/plugin install watcher

# install HQ
sudo /usr/share/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ

# install Phonetic Analysis
sudo /usr/share/elasticsearch/bin/plugin install analysis-phonetic

# start the services
sudo service kibana start
sudo service elasticsearch start

# connect marvel to kibana
sudo /opt/kibana/bin/kibana plugin --install elasticsearch/marvel/latest

# connect sense to kibana
sudo /opt/kibana/bin/kibana plugin --install elastic/sense

# restart all the services so we can use everything on first run!
sudo service kibana restart
sudo service elasticsearch restart