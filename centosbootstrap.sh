#!/bin/bash

# install wget for the next action
sudo yum -y install wget

# download Java
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u73-b02/jdk-8u73-linux-x64.rpm"

# install Java
sudo yum -y localinstall jdk-8u73-linux-x64.rpm

# elasticsearch GPG key
sudo rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

# create the elasticsearch yum repo
echo '[elasticsearch-2.x]
name=Elasticsearch repository for 2.x packages
baseurl=http://packages.elastic.co/elasticsearch/2.x/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1' | sudo tee /etc/yum.repos.d/elasticsearch.repo

# install elasticsearch
sudo yum -y install elasticsearch

# start elasticsearch on boot
#if using System V (check with ps -p 1)
    sudo chkconfig elasticsearch on
#elseif using systemd
#    sudo /bin/systemctl daemon-reload
#    sudo /bin/systemctl enable elasticsearch.service
#fi


# allow host OS to access through port forwarding
sudo echo "network.bind_host: 0" >> /etc/elasticsearch/elasticsearch.yml
sudo echo "network.host: 0.0.0.0" >> /etc/elasticsearch/elasticsearch.yml
sudo sed -i -e '$a\' /etc/elasticsearch/elasticsearch.yml
sudo sed -i -e '$a\' /etc/elasticsearch/elasticsearch.yml

# create the kibana repo
echo '[kibana-4.5]
name=Kibana repository for 4.5.x packages
baseurl=http://packages.elastic.co/kibana/4.5/centos
gpgcheck=1
gpgkey=http://packages.elastic.co/GPG-KEY-elasticsearch
enabled=1' | sudo tee /etc/yum.repos.d/kibana.repo

# install kibana
sudo yum -y install kibana

#start kibana on boot
#if using System V (check with ps -p 1)
    sudo chkconfig --add kibana
#elseif using systemd
#    sudo /bin/systemctl daemon-reload
#    sudo /bin/systemctl enable kibana.service
#fi

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












