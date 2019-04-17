.. role:: raw-html-m2r(raw)
   :format: html


`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`FRINX Features User Guide main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Boron/user_guide.html>`_

CLI Service Module User Guide
=============================

:raw-html-m2r:`<!-- TOC START min:1 max:4 link:true update:true -->`


* `CLI Service Module User Guide <#cli-service-module-user-guide>`_

  * `Usage - Setup <#usage---setup>`_

    * `FRINX ODL - Install features <#frinx-odl---install-features>`_
    * `Optional - Change logging level <#optional---change-logging-level>`_
    * `Postman - Import collection <#postman---import-collection>`_

  * `Introduction <#introduction>`_
  * `Usage - Operations Guide <#usage---operations-guide>`_

    * `Mounting a CLI device <#mounting-a-cli-device>`_

  * `Architecture <#architecture>`_

    * `CLI topology <#cli-topology>`_
    * `CLI mountpoint <#cli-mountpoint>`_

  * `Data processing <#data-processing>`_

    * `Transactions and revert <#transactions-and-revert>`_
    * `Reconciliation <#reconciliation>`_

  * `Supported devices <#supported-devices>`_
  * `Feature history guide <#feature-history-guide>`_

:raw-html-m2r:`<!-- TOC END -->`

Usage - Setup
-------------

FRINX ODL - Install features
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`Run FRINX ODL <../../Operations_Manual/running-frinx-odl-initial.html>`_.

Then within karaf, install the required features:

.. code-block::

   feature:install cli-topology cli-southbound-all-units odl-restconf


This installs the CLI topology and all supported CLI translation units for various platforms e.g. IOS and IOS-XR.

Optional - Change logging level
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you require more detailed logging, then in the karaf terminal, run the following command to enable DEBUG/TRACE logging:

.. code-block::

   log:set TRACE io.frinx.cli


Postman - Import collection
^^^^^^^^^^^^^^^^^^^^^^^^^^^

First follow the instructions `here <../../API.md>`_ to download and use FRINX pre-configured Postman REST calls.

You'll be able to select the FRINX API version that maps to the version of FRINX ODL you are using. The ``Uniconfig Framework`` subdirectory contains the files needed to interact with the CLI.

The sections below (after the Introduction) provide samples of how the CLI southbound plugin can be used to manage a particular device.

Introduction
------------

The CLI southbound plugin enables the FRINX Opendaylight distribution to communicate with CLI devices that do not speak NETCONF or any other programmatic API. The CLI service module uses YANG models and implements a translation logic to send and receive structured data to and from CLI devices. This allows applications to use a service model or unified device model to communicate with a broad range of network platforms and SW revisions from different vendors.

Much like the NETCONF southbound plugin, the CLI southbound plugin enables fully model-driven, transactional device management for internal and external OpenDaylight applications. In fact, the applications are completely unaware of underlying transport and can manage devices over the CLI plugin in the same exact way as over NETCONF.

Once we have mounted the device, we can present an abstract, model-based network device and service interface to applications and users. For example, we can parse the output of an IOS command and return structured data.


.. image:: cliSouthPlugin.png
   :target: cliSouthPlugin.png
   :alt: CLI southbound plugin


Usage - Operations Guide
------------------------

Mounting a CLI device
^^^^^^^^^^^^^^^^^^^^^

The following is an overview of the process by which a CLI device is rendered truly accessible for users and applications:


#. Submit CLI device configuration into CLI topology

   * Over REST, NETCONF or from within Opendaylight

#. CLI topology opens transport layer by opening a session with the device
#. CLI topology collects all the units into a plugin and instantiates translation layer
#. CLI topology builds mountpoint services on top of the translation layer
#. CLI topology exposes the mountpoint into MD-SAL
#. CLI topology updates operational state of this node in CLI topology to connected

You can achieve this as follows:

How to mount and manage IOS devices over REST
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The easiest way is to use one of the REST calls FRINX has already created and packaged in the `FRINX API <../../API.md>`_.
The **FRINX UNIFIED** postman collection (\ ``postman_collection_unified.json``\ ) accessible via that link is  contained within the ``Uniconfig Framework`` directory of the download. It can be imported into Postman and contains subfolders with collections for various devices e.g. **IOS XR**\ , **IOS Classic**\ , **Junos**.  

These contain subfolders **XR Mount**\ , **Classic Mount** and **Junos Mount** respectively, with pre-configured calls for mounting those devices. As explained `here <../../API.md>`_ you will need to import the relevant environment file and update its variables - this is because the calls contains several of these variables (visible in double sets of curly braces in the following image)


.. image:: mount.png
   :target: mount.png
   :alt: mount


Once mounted, several other operations can be undertaken using the calls contained within the other Postman collection subfolders e.g. *General Information, Interface, static route*.

IOS devices can also be mounted and managed from an application. For instructions, please see the end of the `Developer Guide <../../FRINX_Features_Developer_Guide/cli/cli-service-module-devguide.html>`_

How to mount and manage generic Linux VM devices over REST
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It is possible to mount any network device as a generic device. This allows invocation of any commands on the device using RPCs, which return the output back as freeform data and it is up to the user/application to make sense of them.

In postman, open the folder **Linux** to access the Mount call. To configure the variable values, import the ``linux_157_env.json`` environment file from the ``Uniconfig Framework`` directory as explained in the `FRINX API guide <../../API.md>`_


.. image:: linux-mount.png
   :target: linux-mount.png
   :alt: linux mount


Pushing a config to a mounted node in dry run mode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To operate in dry-run mode (useful for testing or demo purposes), you can use one of the Mount cli calls within the imported **FRINX UNIFIED** postman collection (\ **IOS XR/XR Mount/Mount IOS XR cli** or **IOS Classic/Classic Mount/Mount IOS Classic**\ ).


* First change the values of the following lines within the body of the call to the following:  

.. code-block::

   {
       "network-topology:node" :
       {
         "network-topology:node-id" : "IOS",

         "cli-topology:host" : "",
         "cli-topology:port" : "22",
         "cli-topology:transport-type" : "ssh",

         "cli-topology:device-type" : "ios",
         "cli-topology:device-version" : "*",

         "cli-topology:username" : "cisco",
         "cli-topology:password" : "cisco",

         "cli-topology:journal-size": 150,
         "cli-topology:dry-run-journal-size": 180
       }
   }


* Now issue the call, but in the URL instead of using node id, use node-id-dryrun e.g. IOS1-dryrun.

Architecture
------------

This section provides an architectural overview of the plugin, focusing on the main conponents.

CLI topology
^^^^^^^^^^^^

The CLI topology is a dedicated topology instance where users and applications can:


* mount a CLI device
* unmount a device
* check the state of connection
* read/write data from/to a device
* execute RPCs on a device

In fact, this topology can be seen as an equivalent of topology-netconf, providing the same features for netconf devices.

APIs
~~~~

The topology APIs are YANG APIs based on the ietf-topology model. Similarly to netconf topology, CLI topology augments the model with some basic configuration data and also some state to monitor mountpoints. For details please refer to the latest CLI topology YANG model.

CLI mountpoint
^^^^^^^^^^^^^^

The plugin relies on MD-SAL and its concept of mountpoints to expose management of a CLI device into Opendaylight. By exposing a mountpoint into MD-SAL, it enables the CLI topology to actually access the device's data in a structured/YANG manner. Components of such a mountpoint can be divided into 3 distinct layers:


* Service layer - implementation of MD-SAL APIs delegating execution to transport layer.
* Translation layer - a generic and extensible translation layer. The actual translation between YANG and CLI takes place in the extensions. The resulting CLI commands are then delegated to transport layer.
* Transport layer - implementation of various transport protocols used for actual communication with network devices.

The following diagram shows the layers of a CLI mountpoint:


.. image:: cliMountpoint.png
   :target: cliMountpoint.png
   :alt: CLI mountpoint


APIs
~~~~

The mountpoint exposes standard APIs and those are:


* DataBroker
* RpcService
* and (optionally) a NotificationService

These are the basic APIs every mountpoint in MD-SAL needs to provide. The actual data consumed and provided by the services depends on the YANG models implemented for a particular device type.

Translation layer
~~~~~~~~~~~~~~~~~

The CLI southbound plugin is as generic as possible. However, the device-specific translation code (from YANG data -> CLI commands and vice versa), needs to be encapsulated in a device-specific translation plugin. E.g. Cisco IOS specific translation code needs to be implemented by Cisco IOS translation plugin before Opendaylight can manage IOS devices. These translation plugins in conjunction with the generic translation layer allow for a CLI mountpoint to be created.

Device specific translation plugin
""""""""""""""""""""""""""""""""""

Device specific translation plugin is a set of: - YANG models  


* Data handlers  
* RPC implementations

that actually


* defines the model/structure of the data in Opendaylight
* implements the translation between YANG data and device CLI in a set of handlers
* (optionally) implements the translation between YANG rpcs and device CLI

So the plugin itself is responsible for defining the mapping between YANG and CLI. However, the translation layer into which it plugs in is what handles the heavy lifting for it e.g. transactions, rollback, config data storage, reconciliation etc. Additionally, the SPIs of the translation layer are very simple to implement because the translation plugin only needs to focus on the translations between YANG <-> CLI.

Units
#####

In order to enable better extensibility of the translation plugin and also to allow the separation of various aspects of a device's configuration, a plugin can be split into multiple units. Where a unit is actually just a subset of a plugin's models, handlers and RPCs.

A single unit will usually cover a particular aspect of device management e.g. the interface management unit.

Units can be completely independent or they can build on each other, but in the end (in the moment where a device is being mounted) they form a single translation plugin.

Each unit has to be registered under a specific device type(s) e.g. an interface management unit could be registered for various versions of the IOS device type. When mounting an IOS device, the CLI southbound plugin collects all the units registered for the IOS device type and merges them into a single plugin enabling full management.

The following diagram shows an IOS device translation plugin split into multiple units:


.. image:: iosUnits.png
   :target: iosUnits.png
   :alt: IOS translation plugin


Transport layer
~~~~~~~~~~~~~~~

There are various transport protocols available such as:


* SSH
* Telnet

But all of them implement the same APIs, which enables the translation layer of the CLI plugin to be completely independent of the underlying protocol in use. Deciding which transport will be used to manage a particular device is simply a matter of configuration.

Data processing
---------------

There are 2 types of data in the Opendaylight world: Config and Operational. This section details how these data types map to CLI commands.

Just as there are 2 types of data, there are 2 streams of data in the CLI southbound plugin:


* **Config**  

  * user/application intended configuration for the device
  * translation plugins/units need to handle this configuration in data handlers as C(reate), U(pdate) and D(elete) operations - these data flow only towards the device - these data are cached in the mountpoint so when application performs read Config, it gets the cached version


.. image:: readCfg.png
   :target: readCfg.png
   :alt: Config data



* **Operational**

  * actual configuration on the device
  * optionally statistics from the device
  * translation plugins/units need to pull these data out of the device when R(ead) operation is requested


.. image:: readOper.png
   :target: readOper.png
   :alt: Operational data



* **RPCs** stand on their own and can actually encapsulate any command(s) on the device.

Transactions and revert
^^^^^^^^^^^^^^^^^^^^^^^

As mentioned before, configuring a device is performed within transactions. If it's impossible to perform device configuration, the user/app facing transaction is failed and a revert procedure is initiated (in case there was partial configuration already submitted to the device).

Reconciliation
^^^^^^^^^^^^^^

There might be situations where there are inconsistencies between actual configuration on the device and the state cached in Opendaylight. That's why a reconciliation mechanism was developed to:


* Allow the mountpoint to sync its state when first connecting to the device
* Allow apps/users to request synchronization when an inconsistent state is expected e.g. manual configuration of the device

Supported devices
-----------------

Please see `here <cli_supported_devices.md>`_ for a structured list of device types currently supported by the CLI southbound plugin and configuration aspects implemented for them.

*For a hands-on tour of the CLI service module from within your browser, please try our `playground <http://46.229.232.136:7777/>`_\ *

*For more information, please contact us at info@frinx.io*

Feature history guide
---------------------

The following table records the FRINX ODL versions in which particular CLI features and device support were introduced:  

.. list-table::
   :header-rows: 1

   * - FEATURE GUIDE
     - 
     - 
   * - CLI plugin:
     - 
     - 
   * - Feature introduced in
     - FRINX 3.1.1
     - Safe-command-execution for CLI connections - the CLI session now waits for the device to echo back each command. So whenever a device takes longer to process a particular command, FRINX ODL waits before issuing the subsequent one
   * - Feature introduced in
     - FRINX 3.1.1
     - Reconciliation – CLI cache in FRINX ODL can now be also reconciled with 'read configuraton root' (in the case of RESTCONF it’s a GET operation to the entire configuration subtree of a mounted device)
   * - Feature introduced in
     - FRINX 2.3.1
     - Keepalive settings of CLI connection extracted into CLI node configuration
   * - Feature introduced in
     - FRINX 2.3.1
     - Translate registry additional information: Actual YANG model nodes that are supported/implemented are listed for each YANG model
   * - Feature introduced in
     - FRINX 2.3.1
     - Dry-run and journaling capabilities for CLI mountpoint: Enables users to write/read configuration to/from device as a dry-run operation to check what commands will ODL execute. Journal captures all executed commands for a CLI mountpoint and makes them visible for users.
   * - Feature introduced in
     - FRINX 2.3.1
     - VRF support for local routing unit
   * - Feature introduced in
     - FRINX 2.3.0
     - Initial release: CLI service module with support for structured and unstructured data exchange
   * - Device support:
     - 
     - 
   * - Feature introduced in
     - FRINX 3.1.1
     - IOS Classic:Dry-run
   * - Feature introduced in
     - FRINX 3.1.1
     - IOS XR: LAG interfaces
   * - Feature introduced in
     - FRINX 3.1.1
     - IOS XR: TenGigE interfaces
   * - Feature introduced in
     - FRINX 3.1.1
     - IOS XR: MPLS TE, MPLS RSVP
   * - Feature introduced in
     - FRINX 3.1.1
     - IOS XR: ACL
   * - Feature introduced in
     - FRINX 3.1.1
     - IOS XR: ACL
   * - Feature introduced in
     - FRINX 3.1.1
     - IOS XR: logging unit
   * - Feature introduced in
     - FRINX 3.1.1
     - Brocade IronWare: network instance, CDP, IFC, essential, INIT units
   * - Feature introduced in
     - FRINX 3.1.1
     - Adds support for Brocade IronWare
   * - Feature introduced in
     - FRINX 3.1.0
     - Adds support for Cisco IOS XR
   * - Feature introduced in
     - FRINX 2.3.1
     - Openconfig interface YANG models support: Interface Configuration and State read/write support
   * - Feature introduced in
     - FRINX 2.3.1
     - Openconfig interface YANG models support: Interface Ipv4 read/write support
   * - Feature introduced in
     - FRINX 2.3.1
     - Openconfig BGP & RIB YANG models read support
   * - Feature introduced in
     - FRINX 2.3.0
     - Support for Cisco IOS Classic

