## Running workflows to obtain platform inventory data

In this section we show how users can execute workflows to obtain platform inventory data from devices in the network and to store them in the inventory (Elasticsearch).

The goal of this use case is to collect inventory information about physical devices via their vendor specific NETCONF or CLI interfaces, convert this information into OpenConfig data structures and store the resulting information as a child entry to its associated parent in Elasticsearch. The outcome is that users can manage their physical network inventory (line cards, route processors, modules, transceivers, etc …) across different hardware vendors in real-time via a single uniform interface.

### Collect platform information from the device and store in the inventory

In the next step we will execute a workflow that collects platform information from every mounted device, converts the vendor specific information into OpenConfig format and writes the resulting data to the inventory.

Click on “Metadata → Workflow Defs” and select the workflow: “PLATFORM_read_components_all_from_unified_update_inventory”

![preview10](image_16.png)

Once selected, you can execute the workflow without providing additional information.

![preview10](image_17.png)

Under “Executions → All” you can see the progress of the workflow, input/output data of each task and statistics associated with the workflow execution.

![preview10](image_18.png)

![preview10](image_19.png)

![preview10](image_20.png)

![preview10](image_21.png)

After the main and sub-workflows have completed successfully the platform information is now stored in the inventory as a child entry to the device ID that the information comes from.

![preview10](image_22.png)

The execution of all workflows can be manually, via the UI, or can be automated and scheduled via the REST API of conductor server.
