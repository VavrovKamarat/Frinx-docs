
`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`Operations Manual main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Carbon/operations_manual.html>`_

Configuring logging level within karaf
======================================

It's possible to adjust the verbosity of logging for each Frinx ODL feature. Two levels are available - INFO and DEBUG. INFO is less verbose and is a good compromise in terms of verbosity and effectiveness.

After `starting Frinx ODL <running-frinx-odl-after-activation>`_\ , first check the logging level currently set for each feature: within the karaf console type

.. code-block::

   log:list

This will display output similar to the following

.. code-block::

   Logger                                                           | Level
   ------------------------------------------------------------------------
   ROOT                                                             | INFO
   io.frinx                                                         | DEBUG
   io.frinx.cli                                                     | DEBUG
   org.apache.karaf.features                                        | DEBUG
   org.opendaylight                                                 | INFO
   org.opendaylight.controller                                      | INFO
   org.opendaylight.controller.cluster                              | INFO
   org.opendaylight.controller.config.yang.md.sal.connector.netconf | INFO
   org.opendaylight.daexim                                          | INFO
   org.opendaylight.netconf.sal.connect                             | INFO
   org.opendaylight.netconf.topology                                | INFO

To change the logging level for a particular feature e.g. io.frinx.cli type

.. code-block::

   log:set INFO io.frinx.cli

You will see the logging level has been updated when you again type

.. code-block::

   log:list

The output will now be similar to the following, with the level for io.frinx.cli having been changed from DEBUG to INFO:

.. code-block::

   Logger                                                           | Level
   ------------------------------------------------------------------------
   ROOT                                                             | INFO
   io.frinx                                                         | DEBUG
   io.frinx.cli                                                     | INFO
   org.apache.karaf.features                                        | DEBUG
   org.opendaylight                                                 | INFO
   org.opendaylight.controller                                      | INFO
   org.opendaylight.controller.cluster                              | INFO
   org.opendaylight.controller.config.yang.md.sal.connector.netconf | INFO
   org.opendaylight.daexim                                          | INFO
   org.opendaylight.netconf.sal.connect                             | INFO
   org.opendaylight.netconf.topology                                | INFO

To begin viewing the log type

.. code-block::

   log:tail

karaf logs are also written to the data/log directory within your main Frinx ODL distribution directory so can be viewed outside of karaf.
