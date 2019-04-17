
`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`Operations Manual main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Boron/operations_manual.html>`_


.. raw:: html

   <!-- TOC -->




* `FRINX ODL Distribution: Features <#frinx-odl-distribution-features>`_

  * `To install features <#to-install-features>`_

    * `To install for the current karaf session only <#to-install-for-the-current-karaf-session-only>`_


.. raw:: html

   <!-- /TOC -->



FRINX ODL Distribution: Features
================================

The FRINX distribution offers the following features:

.. code-block::

    odlparent
    yangtools
    mdsal
    controller (without xsql)
    netconf
    aaa
    dlux
    topoprocessing
    snmp
    openflowjava
    openflowplugin
    neutron
    sfc
    ovsdb
    gbp
    l2switch
    bgpcep
    lispflowmapping
    cli
    daexim
    faas    
    genius
    netvirt
    honeycomb-vbd
    l2vpn
    l3vpn


To install features
-------------------

To install for the current karaf session only
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To view a list of available features: Within the karaf console type

.. code-block::

   feature:list


To search for a particular feature e.g. restconf you can use grep e.g.

.. code-block::

   feature:list |grep restconf


To install a feature:

.. code-block::

   feature:install odl-restconf
   feature:install odl-netconf-connector-all


Multiple features can be installed on a single line - use a space to separate e.g.:

.. code-block::

   feature:install odl-restconf odl-netconf-connector-all
