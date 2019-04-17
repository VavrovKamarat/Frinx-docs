.. role:: raw-html-m2r(raw)
   :format: html


`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`Operations Manual main page <https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Boron/operations_manual.html>`_

Operating the FRINX ODL Distribution
====================================


.. raw:: html

   <!-- TOC -->




* `Operating the FRINX ODL Distribution <#operating-the-frinx-odl-distribution>`_

  * `Operating in 'regular' mode (karaf in the foreground, with console) <#operating-in-regular-mode-karaf-in-the-foreground-with-console>`_

    * `Starting <#starting>`_
    * `Stopping <#stopping>`_

  * `Operating karaf in the background <#operating-karaf-in-the-background>`_

    * `Starting karaf <#starting-karaf>`_
    * `Confirming karaf is running <#confirming-karaf-is-running>`_
    * `Connecting to the background process <#connecting-to-the-background-process>`_
    * `Stopping the background process <#stopping-the-background-process>`_

  * `Operating karaf in 'server' mode (in the foreground, without the console) <#operating-karaf-in-server-mode-in-the-foreground-without-the-console>`_

    * `Starting karaf <#starting-karaf-1>`_
    * `Confirming karaf is running <#confirming-karaf-is-running-1>`_
    * `Stopping karaf <#stopping-karaf>`_

  * `Resetting FRINX ODL to a clean state <#resetting-frinx-odl-to-a-clean-state>`_
  * `Setting JAVA_HOME and other variables <#setting-java_home-and-other-variables>`_

:raw-html-m2r:`<!-- /TOC -->`
After running for the first time and generating a local license file, you no longer need to provide a token when starting karaf.

This page describes how you can operate the Frinx ODL distribution in different modes. The commands have been tested in CentOS, Ubuntu 16.04 and Ubuntu 18.04.

*Note that Frinx ODL needs approximately 3 minutes to startup and shutdown. To maintain system integrity, **please do not interrupt the startup and shutdown processes** within this time.*\ :raw-html-m2r:`<br>`
*In the event of interruption, the initial state can be restored by entering the following commands from a terminal within your Frinx ODL main directory. The first command forcibly kills the Frinx ODL karaf process; the second command cleans certain directories:*

.. code-block::

   kill -9 $(pgrep  -o -f  karaf)
   rm  -rf  data/ snapshots/ journal/

Operating in 'regular' mode (karaf in the foreground, with console)
-------------------------------------------------------------------

Starting
^^^^^^^^

In your Frinx ODL Distribution directory, for example /home/username/distribution-karaf-3.1.0.frinx, type

.. code-block::

   ./bin/karaf


Stopping
^^^^^^^^

To stop from within the karaf console there are three options:


#. Hold the 'CTRL' key and press the 'd' key
#. Type:
   .. code-block::

       halt

#. Type:
   .. code-block::

       shutdown
   When prompted to confirm, type 'yes'.
   ## Operating karaf in the background
   ### Starting karaf
   In your Frinx ODL Distribution directory, for example /home/username/distribution-karaf-3.1.0.frinx, type
   .. code-block::

       ./bin/start
   ### Confirming karaf is running
   Type
   .. code-block::

       ./bin/status
   ### Connecting to the background process
   Type
   .. code-block::

       ./bin/client
   By default, client tries to connect on localhost, on port 8101 (the default Apache Karaf SSH port). Client accepts different options to let you connect on a remote Apache Karaf instance. You can use --help to get details about these options.

or type

.. code-block::

       ssh karaf@localhost -p 8101

(password: karaf)

(This connection can be local or remote.)

When connected to the background process, you can logout (this closes only the ./bin/client process, but not the Frinx ODL server) by typing

.. code-block::

       logout

When connected to the background process, you can shutdown the Frinx ODL server by typing  

.. code-block::

       shutdown

Stopping the background process
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

With karaf running in the background (from using ./bin/start), stop it from within a terminal by typing

.. code-block::

       ./bin/stop

Operating karaf in 'server' mode (in the foreground, without the console)
-------------------------------------------------------------------------

Starting karaf
^^^^^^^^^^^^^^

In your Frinx ODL Distribution directory, for example /home/username/distribution-karaf-3.1.0.frinx, type

.. code-block::

       ./bin/karaf server &

Confirming karaf is running
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Type

.. code-block::

       ./bin/status

Stopping karaf
^^^^^^^^^^^^^^

Type

.. code-block::

       ./bin/stop

Resetting FRINX ODL to a clean state
------------------------------------

To 'reset' your distribution to a clean state and delete any features previously installed type the following within your frinx ODL distribution directory (e.g. /home/username/distribution-karaf-3.1.0.frinx)

.. code-block::

       rm -rf data/ cache/ journal/ snapshots/

Setting JAVA_HOME and other variables
-------------------------------------

This is done by editing the 'setenv' file in the bin directory within your Frinx ODL Distribution directory. Uncomment the relevant line and set the variable as required e.g. to set the location of your Java home directory, uncomment the JAVA_HOME variable and point it to the appropriate folder depending on your Java installation:

.. code-block::

       export JAVA_HOME=/opt/jdk1.8.0_151
