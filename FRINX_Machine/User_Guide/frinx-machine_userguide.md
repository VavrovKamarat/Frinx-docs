# FRINX Machine User Guide

FRINX Machine is a dockerized deployment of

* **FRINX Opendaylight** (network automation solution)

* and **Netflix Conductor** (workflow engine)

* **Elasticsearch** (inventory and log data)

**The goal is to provide a platform enabling easy definition, execution and monitoring of complex workflows using FRINX Opendaylight.**

In this deployment, responsibilities are separated as follows:

* Opendaylight is used for:

    * Connecting to the devices in network

    * Keeping connections between devices alive

    * Pushing configuration data to devices

    * Pulling configuration and operational data from devices

* Conductor is used for:

    * Chaining atomic tasks into complex workflows

    * Defining, executing, and monitoring workflows (via REST or UI)
  
* Elasticsearch is used for:
  
    * Storing inventory data
  
    * Storing log data

An example workflow could consist of:

1. Pulling device IP and mgmt credentials from an external IPAM system

2. Mounting a device

3. Verifying the device is connected

4. Executing a configuration template

5. Unmounting a device

We chose Netflix’s conductor workflow engine since it has been proven to be highly scalable open-source technology that integrates very well with FRINX Opendaylight. Further information about conductor can be found at:

* **Github**: [https://github.com/Netflix/conductor](https://github.com/Netflix/conductor)

* **Docs:** [https://netflix.github.io/conductor/](https://netflix.github.io/conductor/)

## High Level Architecture

Following diagram outlines main functional components in the FRINX Machine solution:

 ![preview1](image_0.png)

The following diagram outlines the container components of the FRINX Machine solution:

 ![preview](image_1_0.png)

FRINX Machine repository is available at: [https://github.com/FRINXio/FRINX-machine](https://github.com/FRINXio/FRINX-machine)

Frinx-conductor repository is available at: [https://github.com/FRINXio/frinx-conductor](https://github.com/FRINXio/frinx-conductor)

Specialized ODL tasks are available at: [https://github.com/FRINXio/netinfra_utils](https://github.com/FRINXio/netinfra_utils) 

## Defining a workflow

Workflows are defined using a JSON based domain specific language (DSL) by wiring a set of tasks together. The tasks are either control tasks (fork, conditional etc) or application tasks (e.g. encode a file) that are executed on a remote machine.

FRINX Machine distribution comes in with number of pre-packaged workflows.

Detailed description of workflow and task definitions along with examples can be found at official [Netflix Conductor documentation](https://netflix.github.io/conductor/metadata/#workflow-definition).

## Starting a workflow

Open **conductor-ui** at *host:5000 *and navigate to **_Metadata > Workflow Defs_**, there is a list of all available workflow definitions, choose one and switch to tab **_Input_**.

![preview1](image_1.png)

### Input

Workflows are supplied inputs by client when a new execution is triggered. Workflow input is a JSON payload that is available via ${workflow.input...} expressions.

Each task in the workflow is given input based on the inputParameters template configured in workflow definition. inputParameters is a JSON fragment with value containing parameters for mapping values from input or output of a workflow or another task during the execution.

### Start workflow

Fill in JSON generated input fields. Input fields may contain default value or description provided in workflow definition. 

Press the button **_Execute workflow_** in order to start current workflow. 

**Console log** provides status information about workflow execution.

![preview2](image_2.png)

Executed workflows can be found at **_Executions_** tab in left menu.

## Inspecting executed workflows 

Navigate to **_Executions > All_**, where you are able to search and filter for specific workflows.

After clicking on specific workflow, you are able to see its details including outputs as well as other information about current workflow.

![preview3](image_3.png)

### Workflow actions 

Workflow actions are available after clicking on specific executed workflow. 

You are able to: **_terminate, rerun, restart, retry, pause or resume_** specific workflow. 

If you want to run previously executed workflow as new workflow with same or edited inputs, navigate to **Edit Input** tab, where you are able to edit specific inputs and run workflow again.

![preview4](image_4.png)
