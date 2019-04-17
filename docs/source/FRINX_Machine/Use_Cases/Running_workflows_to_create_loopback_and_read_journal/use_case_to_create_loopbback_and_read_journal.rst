
Running workflows to create loopback address on devices and check the journal
=============================================================================

In this section we show how users can execute workflows to create loopback address on devices stored in the inventory.

Create loopback address on devices stored in the inventory
----------------------------------------------------------

In the next step we will execute a workflow that creates loopback on every mounted device from inventory.

Click on:


* Metadata

  * Workflow Defs

Then select the workflow:
**OC-INTERFACES_create_loopback_all_from_unified**


.. image:: image1.png
   :target: image1.png
   :alt: preview10


After providing the loopback id to be used, you can execute the workflow.


.. image:: image2.png
   :target: image2.png
   :alt: preview10


Under


* Executions

  * All

You can see the progress of the workflow, input/output data of each task and statistics associated with the workflow execution.


.. image:: image3.png
   :target: image3.png
   :alt: preview10



.. image:: image4.png
   :target: image4.png
   :alt: preview10


The workflow creates a loopback for all devices in the inventory. Here you see all the devices.


.. image:: image5.png
   :target: image5.png
   :alt: preview10



.. image:: image6.png
   :target: image6.png
   :alt: preview10


After the main and sub-workflows have completed successfully the loopback addres was created on the devices.
Since we are working with emulated devices, we can check a device journal ro see if it was really created.

The execution of all workflows can be manually, via the UI, or can be automated and scheduled via the REST API of conductor server.

Running the workflow for retrieving the journal of a device
-----------------------------------------------------------

In this section we show how to run the workflow for retrieving the journal of a device.

Click on:


* Metadata

  * Workflow Defs

Then select the workflow:
**SOUTHBOUND_read_journal_cli_device**


.. image:: image7.png
   :target: image7.png
   :alt: preview10


After providing the device id(you need to specify the id under you mounted the device), you can execute the workflow.


.. image:: image8.png
   :target: image8.png
   :alt: preview10


Under


* Executions

  * All

You can see the progress of the workflow, input/output data of each task and statistics associated with the workflow execution.


.. image:: image9.png
   :target: image9.png
   :alt: preview10



.. image:: image10.png
   :target: image10.png
   :alt: preview10


The journal information can be found in the output of the workflow. To transform to a readable format you need to unescape the line.


.. image:: image11.png
   :target: image11.png
   :alt: preview10

