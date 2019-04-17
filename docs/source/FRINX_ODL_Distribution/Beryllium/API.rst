.. role:: raw-html-m2r(raw)
   :format: html


`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_  

API - Postman
=============


.. raw:: html

   <!-- TOC -->




* `API - Postman <#api---postman>`_

  * `Download Postman (free) <#download-postman-free>`_
  * `Download FRINX Postman collection and environment files <#download-frinx-postman-collection-and-environment-files>`_
  * `Importing FRINX Postman collection & environment files into Postman <#importing-frinx-postman-collection--environment-files-into-postman>`_

    * `Configuring environments <#configuring-environments>`_
    * `Activating an environment <#activating-an-environment>`_

  * `Versioning <#versioning>`_

    * `Main releases <#main-releases>`_
    * `Release candidates <#release-candidates>`_
    * `Backwards compatibility <#backwards-compatibility>`_

:raw-html-m2r:`<!-- /TOC -->`

Download Postman (free)
-----------------------

FRINX uses the free Postman REST client as an API for the FRINX ODL distribution. `Download Postman for your system <https://www.getpostman.com/postman>`_

Download FRINX Postman collection and environment files
-------------------------------------------------------

We have created collections of REST calls that form the API for the FRINX ODL distribution.
These REST calls are grouped together as **Postman collection** files. 

For some features we also provide **Postman environment** files (with suffix env.json). These make the REST calls easily configurable through the use of variables, whose values you can edit (see section below in importing).

Both the FRINX **Postman collection** and **Postman environment** files are grouped by FRINX ODL release (starting with 3.1.1) and packaged as zip files `here <https://github.com/FRINXio/Postman/releases>`_. 

On that page, find your FRINX ODL version number and click on 'zip' to download to a location on your local machine. 


.. image:: zip-files.png
   :target: zip-files.png
   :alt: Select release
  

In a terminal on your local machine, unzip the file. This will create a new directory with the 
following subdirectories, grouped by FRINX ODL features: 


* ``Infrastructure``          - `Bundle API <FRINX_Features_User_Guide/using-the-frinx-api-bundle.md>`_\ , `Clustering <Operations_Manual/clustering-overview>`_
* ``L2VPN Service Module``    - `L2VPN <FRINX_Features_User_Guide/l2vpn/l2vpn-service-module.md>`_
* ``L3VPN Service Module``    - `L3VPN <FRINX_Features_User_Guide/l3vpn/l3vpn-service-module.md>`_
* ``Uniconfig Framework``     - `CLI <FRINX_Features_User_Guide/cli/cli-service-module.md>`_\ , `Uniconfig <FRINX_Features_User_Guide/uniconfig/architecture/architecture.md>`_  

Importing FRINX Postman collection & environment files into Postman
-------------------------------------------------------------------

Start Postman and click on **Import** near the top-left of the screen.

In the pop-up window which opens, click **Choose files** and navigate into the subdirectory of your choice (Infrastructure, L2VPN Service Module, L3VPN Service Module or Uniconfig Framework) and select a postman_collection.json file to import (both collection files and environment files are imported from here). 


.. image:: import.png
   :target: import.png
   :alt: Import into Postman
  

Imported **Collection files** appear as folders on the left of the screen. They contain sets of REST calls which allow you to interact with FRINX ODL and to use FRINX ODL to interact with network devices.


.. image:: imported-collection.png
   :target: imported-collection.png
   :alt: Imported collection
  

Configuring environments
^^^^^^^^^^^^^^^^^^^^^^^^

The advantage of setting environments is that you can re-use the same variable name throughout the URL and body of multiple calls, and update its value in one location.

You can create your own environments, but you can also make use of environments we have created to save time. You can re-use our keys, but you will need to update the values according to your setup:

Imported **Environment files** contain variables whose values you can update by clicking on the cog icon near the top-right of Postman and selecting **Manage Environments**.  


.. image:: manage-envs.png
   :target: manage-envs.png
   :alt: Manage environments
  

All the environments you have imported or created will be listed:  


.. image:: environments.png
   :target: environments.png
   :alt: Environments
  

CLick on the environment you wish to edit. You are then able to set values for each key (variable):


.. image:: update-envs.png
   :target: update-envs.png
   :alt: Update-envs
  

Click on **Update** to save your changes.

Activating an environment
^^^^^^^^^^^^^^^^^^^^^^^^^

Next you need to select your choice of environment from the drop-down menu in the top right of screen:

 
.. image:: select-env.png
   :target: select-env.png
   :alt: Select environment
  

The value you set for each key when you configured the selected environment is substituted for the key wherever it appears within the body or URL of any REST call you issue while that environment is active. When using keys within calls, they should be encapsulated in double sets of curly braces (our postman collection calls are already set up this way):

 
.. image:: env-keys.png
   :target: env-keys.png
   :alt: Environment keys
  

Versioning
----------

Main releases
^^^^^^^^^^^^^

Distinct versions of the FRINX Postman API files are `available here <https://github.com/FRINXio/Postman/releases>`_\ , and named in the following format to correspond to analogous FRINX ODL distributions:  

.. code-block::

   release-x.x.x.frinx  


for example 

.. code-block::

   release-3.1.1.frinx


Release candidates
^^^^^^^^^^^^^^^^^^

Between releases we also publish release candidate (RC) zip files `in the same location <https://github.com/FRINXio/Postman/releases>`_ which are pre-release versions in the development stage. These correspond with pre-release versions of FRINX ODL. The naming format is:  

.. code-block::

   release-x.x.x.rcx-frinx


for example

.. code-block::

   release-3.1.1.rc2-frinx


Backwards compatibility
^^^^^^^^^^^^^^^^^^^^^^^

Backwards compatibility of FRINX Postman collections:\ :raw-html-m2r:`<br>`
``Infrastructure``        - Works with all releases of Carbon, Boron, Beryllium FRINX ODL\ :raw-html-m2r:`<br>`
``L2VPN Service Module``  - Works with all releases of Carbon, Boron FRINX ODL\ :raw-html-m2r:`<br>`
``L3VPN Service Module``  - Works with all releases of Carbon, Boron FRINX ODL\ :raw-html-m2r:`<br>`
``Uniconfig Framework``   - Works only with corresponding version of FRINX ODL  
