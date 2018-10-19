## Collect LLDP Information from Devices and Build Topology

​In the following step we will start a workflow that goes to each mounted device, collects LLDP information, reconciles that information and finally stores that information in the inventory.

​To run the workflow click on click on "Metadata → Workflow Defs" and select: "LLDP_build_read_store".

​Go to the input tab of the workflow. The workflow has default parameters filled out for you and you can click on "Execute workflow".

​![alt_text](conductor_user28.png "image_tooltip")

​After the workflow has completed, go to Kibana and look for an entry called "lldp". You should see a similar view like the following:

​![alt_text](conductor_user29.png "image_tooltip")

​Exporting the IETF topology information in graphviz format:

​To export the LLDP topology data in a format that can be used for visualization in 3rd party tools run the following workflow:

​Click on "Metadata → Workflow Defs" and select: "LLDP_export". You should see a similar view like this:

​![alt_text](conductor_user30.png "image_tooltip")

​Now click on the workflow ID and click on the green box with the workflow name to display the workflow output details. Copy the escaped string under "response body" / "output" / "export" and unescape the string with a tool like this "[https://www.freeformatter.com/json-escape.html](https://www.freeformatter.com/json-escape.html)":

​![alt_text](conductor_user31.png "image_tooltip")

​Finally you can use any 3rd party visualization tool that can support the graphviz format like "[https://dreampuf.github.io/GraphvizOnline/](https://dreampuf.github.io/GraphvizOnline/)":

​![alt_text](conductor_user32.png "image_tooltip")

​All workflows can be executed manually as shown in this demo or can be scheduled via the workflow scheduling features.
