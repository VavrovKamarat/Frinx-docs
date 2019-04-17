.. role:: raw-html-m2r(raw)
   :format: html


`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`Beryllium Release Notes main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Beryllium/release_notes.html>`_

frinx-odl-base-feature-content-rel-1-4-1
========================================

This document describes the latest changes, additions, known issues, and fixes for the Frinx ODL Distribution.  

New Features, Improvements
~~~~~~~~~~~~~~~~~~~~~~~~~~


#. :raw-html-m2r:`<span class="line">Basic clustering on top of odl-netconf-topology: Fixed optimistic locking issues implementing retry mechanism in odl-netconf-topology to allow this feature to be run in cluster.</span>`

Known Issues
~~~~~~~~~~~~


#. Clustering related issues with feature "odl-netconf-clustered-topology" - please use "odl-netconf-topology" instead.
#. Netconf topology `1 <https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#Authentication.2C_Authorization_and_Accounting_.28AAA.29>`_ does not report connection issues - reports connected even if keepalive message is not received. Underlying connection reconnect functionality works as expected. `1 <https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#Authentication.2C_Authorization_and_Accounting_.28AAA.29>`_\ : available via restconf URL http://${ODL_HOST}:8181/restconf/operational/network-topology:network-topology/topology/topology-netconf/

Opendaylight Beryllium SR4 Release Notes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Frinx controller 1.4.1 is based on Opendaylight Beryllium SR4. Where a feature is present in both controllers, the same Release Notes apply

https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes\ :raw-html-m2r:`<br>`
odlparent https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#ODL_Root_Parent\ :raw-html-m2r:`<br>`
yangtools https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#YANG_Tools\ :raw-html-m2r:`<br>`
mdsal https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#MD-SAL\ :raw-html-m2r:`<br>`
controller (without xsql) https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#Controller\ :raw-html-m2r:`<br>`
netconf https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#NETCONF\ :raw-html-m2r:`<br>`
aaa `https://wiki.opendaylight.org/view/SimultaneousRelease/Beryllium/SR4/Release_Notes#Authentication.2C_Authorization_and_Accounting.28AAA.29 <https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#Authentication.2C_Authorization_and_Accounting_.28AAA.29>`_\ :raw-html-m2r:`<br>`
dlux topoprocessing https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#Topology_Processing_Framework\ :raw-html-m2r:`<br>`
snmp https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#SNMP_Plugin\ :raw-html-m2r:`<br>`
openflowjava and openflowplugin https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#OpenFlow_Plugin\ :raw-html-m2r:`<br>`
neutron `https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#Neutron_Northbound <https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#OpenFlow_Plugin>`_\ :raw-html-m2r:`<br>`
sfc https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#Service_Function_Chaining\ :raw-html-m2r:`<br>`
ovsdb (without netvirt) https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#OVSDB_Integration\ :raw-html-m2r:`<br>`
gbp `https://wiki.opendaylight.org/view/Simultaneous*Release/Beryllium/SR4/Release_Notes#Group_Based_Policy*.28 <https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#Group_Based_Policy_.28>`_\ :raw-html-m2r:`<br>`
l2switch https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#L2_Switch\ :raw-html-m2r:`<br>`
bgpcep https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#BGP_PCEP\ :raw-html-m2r:`<br>`
lispflowmapping https://wiki.opendaylight.org/view/Simultaneous_Release/Beryllium/SR4/Release_Notes#LISP_Flow_Mapping [/wpmem_form]
