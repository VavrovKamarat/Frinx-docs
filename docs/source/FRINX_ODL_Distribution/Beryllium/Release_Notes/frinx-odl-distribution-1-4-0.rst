.. role:: raw-html-m2r(raw)
   :format: html


`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`Beryllium Release Notes main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Beryllium/release_notes.html>`_

frinx-odl-base-feature-content-rel-1-4-0
========================================

This document describes the latest changes, additions, known issues, and fixes for the Frinx ODL Distribution. 

New Features, Improvements
~~~~~~~~~~~~~~~~~~~~~~~~~~


#. :raw-html-m2r:`<span class="line">Added new netconf API and ALU/SROS specific customization</span>`
#. :raw-html-m2r:`<span class="line">GBP-base now cluster aware -  Cluster awareness is achieved through the use of the Entity Ownership Service -  ClusteredPolicyResolver has been created as a clustered version of PolicyResolver -  The new karaf feature "odl-groupbasedpolicy-clustered" runs a clustered version of policy resolver and endpoint registry1. <em>Note: Feature "odl-groupbasedpolicy-clustered" must be installed instead of feature "odl-groupbasedpolicy-base" when ODL is run on more than one cluster node</em></span>`
#. Fixed bug for keepalive in "odl-netconf-clustered-topology"

Known Issues
~~~~~~~~~~~~


#. Clustering related issues with netconf (feature "odl-netconf-clustered-topology") -  Node does not always reconnect after temporal isolation -  Occasionally the netconf connection between one or more nodes and the netconf device is not established or is dropped after the hello message is transmitted.

Opendaylight Beryllium SR4 Release Notes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Frinx controller 1.4.0 is based on Opendaylight Beryllium SR4. Where a feature is present in both controllers, the same Release Notes apply

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
