
`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`Boron Release Notes main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Boron/release_notes.html>`_

frinx-odl-distribution-2-2-0
============================

This document describes the latest changes, additions, known issues, and fixes for the FRINX ODL Distribution.  

**Note that FRINX ODL distribution 2.2.0 requires Java 8**

New Features, Improvements
~~~~~~~~~~~~~~~~~~~~~~~~~~


#. The Daexim project has been backported from OpenDaylight to the FRINX distribution.
#. Improved Alcatel-Lucent NETCONF support.
#. Fixed a race condition in NETCONF topology which resulted in the operational datastore not being deleted when deleting the device from the config datastore.

Known Issues
~~~~~~~~~~~~


#. Clustering related issues with feature “odl-netconf-clustered-topology” – please use “odl-netconf-topology” instead.
#. Netconf topology does not report connection issues – reports connected even if keepalive message is not received. Underlying connection reconnect functionality works as expected.

Opendaylight Boron Release Notes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FRINX ODL distribution is based on Opendaylight Boron.

https://wiki.opendaylight.org/view/Simultaneous_Release/Boron/Release_Notes

[/wpmem_form]
