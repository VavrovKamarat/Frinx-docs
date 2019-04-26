[Documentation main page](https://frinxio.github.io/Frinx-docs/)
[Operations Manual main page](https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Carbon/operations_manual.html)
# Elasticsearch
<!-- TOC -->

- [Elasticsearch](#elasticsearch)
    - [Installation](#installation)
    - [Configuration](#configuration)
        - [Configure Log4j](#configure-log4j)
        - [Configure Logstash](#configure-logstash)
    - [Operation](#operation)
    - [Other links](#other-links)

## Installation
1\. If you have not already done so, [Download the FRINX ODL distribution][1] and [install it][2]  
2\. [Install Elasticsearch][3]

In the unpackaged folder, start elasticsearch with

    ./bin/elasticsearch


3\. [Install Kibana][4] - download the version appropriate to your system. For the Linuz-64 bit tar.gz download file, unpackage it with

    tar -xvf filename


In the unpackaged folder, start kibana with

    ./bin/kibana


4\. [Install logstash][5] - which we'll use for collecting and parsing log files. It can transform an unstructured log into something meaningful and searchable.

For the Linuz-64 bit tar.gz download file, unpackage it with

    tar -xvf filename


## Configuration
The base configuration is to use log4j socket listener for Logstash and the log4j socket appender in ODL FRINX.

### Configure Log4j
Within the home directory of your FRINX ODL distribution, go to the **etc** directory.
Backup your old config file:  

    cp org.ops4j.pax.logging.cfg org.ops4j.pax.logging.cfg.bkp

Copy [org.ops4j.pax.logging.cfg](org.ops4j.pax.logging.cfg) into the same folder. The root logger section (near the top) of this file has been adjusted to log to elastic search.

### Configure Logstash
We must now configure socket listener for Logstash:

From your logstash directory(the directory created from unpackaging the download file at the start of this guide), move into the config directory:

    cd config

Copy this template [logstash.conf file](logstash.conf) into that config directory.

Edit line 7 of logstash.conf to point to karaf_home/data/log/karaf.log (it is currently set to /mnt/karaf.log).

Put the [odl file](odl) in /mnt/patterns/ or whatever directory you choose to set in line 18 of logstash.conf. For more info on custom patterns please see <https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html#_custom_patterns>

For more info on logstash and log4j see: [Getting started with Logstash][6] and [Log4j][7]

We started elasticsearch and kibana after downloading them (see the start of this guide).

We now need to start logstash. Move to your main logstash folder:

    cd ..


The start logstash with

    ./bin/logstash -f config/frinx.conf


## Operation
We have already started elasticsearch, kibana, and logstash. Now start karaf as normal by going to your FRINX ODL Distribution main directory for example distribution-karaf-2.3.0.frinx.

Then type

    ./bin/karaf


All logging information is now logged to an Elasticsearch node though Logstash. This information can be analysed with Kibana. Open Kibana in a Web browser by going to <http://localhost:5601>

## Other links   
[Elastic search products][8]  
[Running Logstash and Elasticsearch in docker][9]  
[How To Install Elasticsearch, Logstash, and Kibana (ELK Stack) on Ubuntu 14.04][10]

 [1]: https://frinx.io//downloads/ "FRINX distribution"
 [2]: running-frinx-odl-initial.md
 [3]: https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html
 [4]: https://www.elastic.co/downloads/kibana
 [5]: https://www.elastic.co/downloads/logstash
 [6]: https://www.elastic.co/guide/en/logstash/current/getting-started-with-logstash.html "Getting started with Logstash"
 [7]: https://www.elastic.co/guide/en/logstash/current/plugins-inputs-log4j.html "Log4j"
 [8]: https://www.elastic.co/products "Elastic search products"
 [9]: https://www.elastic.co/guide/en/logstash/current/docker.html "Running Logstash and Elastic Search in Docker"
 [10]: https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04 "How To Install Elasticsearch, Logstash, and Kibana (ELK Stack) on Ubuntu 14.04"
