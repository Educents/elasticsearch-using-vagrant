# Elastic Search using Vagrant
An easy to install vagrant setup using Elasticsearch 2.3.1 and some very useful plugins.

## Installation
* First, make sure you have VirtualBox installed. You can grab the latest version here: [Downloads - Oracle VM VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Make sure you have vagrant installed. You can grab the latest version here: [Download - Vagrant by HashiCorp](https://www.vagrantup.com/downloads.html)

### Ubuntu VM

```
$ git clone https://github.com/Educents/elasticsearch-using-vagrant ./vm-elastic
$ cd vm-elastic && vagrant up
```

## Usage
After installing the ElasticSearch server, you'll be able to head over to [http://localhost:9200/](http://localhost:9200/) to check the current ElasticSearch information.

A few plugins have been installed for you:

* Kibana ([http://localhost:5601/](http://localhost:5601/))
