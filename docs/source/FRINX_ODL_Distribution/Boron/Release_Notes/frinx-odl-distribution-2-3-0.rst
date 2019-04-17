.. role:: raw-html-m2r(raw)
   :format: html


`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`Boron Release Notes main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Boron/release_notes.html>`_

frinx-odl-distribution-2-3-0
============================

This document describes the latest changes, additions, known issues, and fixes for the FRINX ODL Distribution.\ :raw-html-m2r:`<!--more-->`

**Note that FRINX ODL distribution 2.3.0 requires Java 8**

New Features, Improvements
~~~~~~~~~~~~~~~~~~~~~~~~~~


#. Added CLI service module to enable the controller to manage devices over a CLI 
#. Added L3VPN for automated provisioning of Layer 3 Virtual Private Networks (L3VPN) on Service Provider (SP) routers

Known Issues
~~~~~~~~~~~~


#. After node isolation netconf clustering does not function correctly
#. GBP-features odl-groupbasedpolicy-clustered and odl-groupbasedpolicy-noop does not function correctly

**\ *Note - running feature:install odl-l3vpn produces an error message, shown below. This error message is benign and can be ignored; l3vpn works as expected*\ :raw-html-m2r:`<br>`
Error message:**

2017-07-13 14:13:53,123 | ERROR | l for user karaf | lBundleScanningSchemaServiceImpl | 169 - org.opendaylight.controller.sal-schema-service - 1.4.3.Boron-SR3_2_3_0-frinxodl | Exception occured during invoking listener\ :raw-html-m2r:`<br>`
org.opendaylight.netconf.sal.restconf.impl.RestconfDocumentedException: errors: [RestconfError [error-type: application, error-tag: operation-failed, error-message: name doesn't exist.]] at org.opendaylight.restconf.utils.mapping.RestconfMappingNodeUtil.findNodeInGroupings(RestconfMappingNodeUtil.java:369) at org.opendaylight.restconf.utils.mapping.RestconfMappingNodeUtil.addChildOfModuleBySpecificModule(RestconfMappingNodeUtil.java:350) at org.opendaylight.restconf.utils.mapping.RestconfMappingNodeUtil.addDeviationList(RestconfMappingNodeUtil.java:195) at org.opendaylight.restconf.utils.mapping.RestconfMappingNodeUtil.fillMapByModules(RestconfMappingNodeUtil.java:132) at org.opendaylight.restconf.utils.mapping.RestconfMappingNodeUtil.mapModulesByIetfYangLibraryYang(RestconfMappingNodeUtil.java:90) at org.opendaylight.restconf.handlers.SchemaContextHandler.onGlobalContextUpdated(SchemaContextHandler.java:63) at org.opendaylight.controller.sal.schema.service.impl.GlobalBundleScanningSchemaServiceImpl.notifyListeners(GlobalBundleScanningSchemaServiceImpl.java:156)

Opendaylight Boron Release Notes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FRINX ODL distribution 2.3.0 is based on Opendaylight Boron.

https://wiki.opendaylight.org/view/Simultaneous_Release/Boron/Release_Notes
