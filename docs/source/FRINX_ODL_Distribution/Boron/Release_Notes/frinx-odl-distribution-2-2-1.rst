.. role:: raw-html-m2r(raw)
   :format: html


`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`Boron Release Notes main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Boron/release_notes.html>`_

frinx-odl-distribution-2-2-1
============================

This document describes the latest changes, additions, known issues, and fixes for the FRINX ODL Distribution.  

**Note that FRINX ODL distribution 2.2.1 requires Java 8**

New Features, Improvements
~~~~~~~~~~~~~~~~~~~~~~~~~~


#. Added Radius authentication to the AAA project. 
#. Fixed Angular dependency injections in the FRINX Feature Installer. 
#. Fixed JUnits tests which were failing in Jenkins. 
#. Changed naming of the ODL dependency versions. The pattern is now: major.minor.micro.classifier For example in the case of 0.7.2-Boron-SR2.2_2_1-frinxodl:\ :raw-html-m2r:`<br>`
   Major is: 0\ :raw-html-m2r:`<br>`
   Minor is: 7\ :raw-html-m2r:`<br>`
   Micro is: 2-Boron-SR2\ :raw-html-m2r:`<br>`
   Classifier is: 2_2_1-frinxodl\ :raw-html-m2r:`<br>`
   Previously, the classifier was of the format x-frinxodl, where x was an integer autoincremented with each release. 

Known Issues
~~~~~~~~~~~~


#. Clustering related issues with feature “odl-netconf-clustered-topology” – please use “odl-netconf-topology” instead.
#. Netconf topology does not report connection issues – reports connected even if keepalive message is not received. Underlying connection reconnect functionality works as expected.

Opendaylight Boron Release Notes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

FRINX ODL distribution 2.2.1 is based on Opendaylight Boron.

https://wiki.opendaylight.org/view/Simultaneous_Release/Boron/Release_Notes
