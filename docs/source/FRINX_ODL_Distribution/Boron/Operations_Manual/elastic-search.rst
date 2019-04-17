.. role:: raw-html-m2r(raw)
   :format: html


`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`Operations Manual main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Boron/operations_manual.html>`_

Elasticsearch
=============


.. raw:: html

   <!-- TOC -->




* `Elasticsearch <#elasticsearch>`_

  * `Installation <#installation>`_
  * `Configuration <#configuration>`_

    * `Configure Log4j <#configure-log4j>`_
    * `Configure Logstash <#configure-logstash>`_

  * `Operation <#operation>`_
  * `Other links <#other-links>`_

Installation
------------

1. If you have not already done so, :raw-html-m2r:`<a href="https://frinx.io//downloads/" title="FRINX distribution">Download the FRINX ODL distribution</a>` and `install it <running-frinx-odl-initial.md>`_\ :raw-html-m2r:`<br>`
2. `Install Elasticsearch <https://www.elastic.co/guide/en/elasticsearch/reference/current/install-elasticsearch.html>`_

In the unpackaged folder, start elasticsearch with

.. code-block::

   ./bin/elasticsearch



3. `Install Kibana <https://www.elastic.co/downloads/kibana>`_ - download the version appropriate to your system. For the Linuz-64 bit tar.gz download file, unpackage it with

.. code-block::

   tar -xvf filename



In the unpackaged folder, start kibana with

.. code-block::

   ./bin/kibana



4. `Install logstash <https://www.elastic.co/downloads/logstash>`_ - which we'll use for collecting and parsing log files. It can transform an unstructured log into something meaningful and searchable.

For the Linuz-64 bit tar.gz download file, unpackage it with

.. code-block::

   tar -xvf filename



Configuration
-------------

The base configuration is to use log4j socket listener for Logstash and the log4j socket appender in ODL FRINX.

Configure Log4j
^^^^^^^^^^^^^^^

Within the home directory of your FRINX ODL distribution, go to the **etc** directory.
Backup your old config file:  

.. code-block::

   cp org.ops4j.pax.logging.cfg org.ops4j.pax.logging.cfg.bkp


Copy `org.ops4j.pax.logging.cfg <org.ops4j.pax.logging.cfg>`_ into the same folder. The root logger section (near the top) of this file has been adjusted to log to elastic search.

Configure Logstash
^^^^^^^^^^^^^^^^^^

We must now configure socket listener for Logstash:

From your logstash directory(the directory created from unpackaging the download file at the start of this guide), move into the config directory:

.. code-block::

   cd config


Copy this template `logstash.conf file <logstash.conf>`_ into that config directory.

Edit line 7 of logstash.conf to point to karaf_home/data/log/karaf.log (it is currently set to /mnt/karaf.log). 

Put the `odl file <odl>`_ in /mnt/patterns/ or whatever directory you choose to set in line 18 of logstash.conf. For more info on custom patterns please see https://www.elastic.co/guide/en/logstash/current/plugins-filters-grok.html#_custom_patterns

For more info on logstash and log4j see: :raw-html-m2r:`<a href="https://www.elastic.co/guide/en/logstash/current/getting-started-with-logstash.html" title="Getting started with Logstash">Getting started with Logstash</a>` and :raw-html-m2r:`<a href="https://www.elastic.co/guide/en/logstash/current/plugins-inputs-log4j.html" title="Log4j">Log4j</a>`

We started elasticsearch and kibana after downloading them (see the start of this guide).

We now need to start logstash. Move to your main logstash folder:

.. code-block::

   cd ..



The start logstash with

.. code-block::

   ./bin/logstash -f config/frinx.conf



Operation
---------

We have already started elasticsearch, kibana, and logstash. Now start karaf as normal by going to your FRINX ODL Distribution main directory for example distribution-karaf-2.3.0.frinx.

Then type

.. code-block::

   ./bin/karaf



All logging information is now logged to an Elasticsearch node though Logstash. This information can be analysed with Kibana. Open Kibana in a Web browser by going to http://localhost:5601

Other links
-----------

:raw-html-m2r:`<a href="https://www.elastic.co/products" title="Elastic search products">Elastic search products</a>`\ :raw-html-m2r:`<br>`
:raw-html-m2r:`<a href="https://www.elastic.co/guide/en/logstash/current/docker.html" title="Running Logstash and Elastic Search in Docker">Running Logstash and Elasticsearch in docker</a>`\ :raw-html-m2r:`<br>`
:raw-html-m2r:`<a href="https://www.digitalocean.com/community/tutorials/how-to-install-elasticsearch-logstash-and-kibana-elk-stack-on-ubuntu-14-04" title="How To Install Elasticsearch, Logstash, and Kibana (ELK Stack) on Ubuntu 14.04">How To Install Elasticsearch, Logstash, and Kibana (ELK Stack) on Ubuntu 14.04</a>`
