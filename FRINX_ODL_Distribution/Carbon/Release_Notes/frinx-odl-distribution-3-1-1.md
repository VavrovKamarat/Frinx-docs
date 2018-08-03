[Documentation main page](https://frinxio.github.io/Frinx-docs/)
[Carbon Release Notes main page](https://frinxio.github.io/Frinx-docs/FRINX_ODL_Distribution/Carbon/release_notes.html)

This document describes the latest changes, additions, known issues, and fixes for the Frinx ODL Distribution.<!--more-->

**Note: Frinx CLI plugin safe command execution - Frinx ODL distribution 3.1.1 introduces safe command execution to the [Frinx CLI plugin](../FRINX_Features_User_Guide/cli/cli-service-module.md). This forces the cli session to wait for the device to echo back each command before issuing another command. To implement safe command execution, remove the following line (boxed in red in the image below) when issuing the Mount IOS XR cli REST call within Postman. For more info on using the Frinx API and Postman see [our guide](../API.md)**

![safe command execution](safe-command-execution.png)

**Note that FRINX ODL distribution 3.1.1 requires Java 8 (Openjdk 1.8.0-171 or newer)**
To install Java:  
Ubuntu: In a terminal type

    sudo apt-get install openjdk-8-jre

CentOS: In a terminal type

    sudo yum install java-1.8.0-openjdk

#### New Features, Improvements
1. UniConfig framework has been added.
2. Switches to G1 garbage collector.
3. Uses 4GB heap by default.
4. Enables crash on out of memory JVM flag.

#### Known Issues
1. odl-netconf-clustered-topology:
    * Contains critical bugs and is not intended for production use, so odl-netconf-topology was modified FRINX so that it can work in cluster. FRINX recommends to use odl-netconf-topology in production environments.
2. restconf/operational/entity-owners:
    * entity-owners contains no data as entity ownership service was rewritten. Entity owners are assigned to the same node that hosts shard leaders.
3. CLI telnet connectivity with reverse telnet on Cisco devices is not supported in this release.
4. CLI, UniConfig framework, and L2/3VPN service modules are supported on single node ODL.
5. Readers returning default data for non-existent instances.
    * When a specific query is issued for some child reader e.g. AreaReader in OSPF for XR, it will return default data back instead of a 404 response.
6. UniConfig:
    * Connection status is not shown under unified node
    * *Workaround is to check connection status under CLI/NETCONF node*
    * Uniconfig node is not removed from CONF DS when CLI/NETCONF node is unmount
    * *Workaround is to remove uniconfig node manually e.g.:*
```
  curl -X DELETE \
    http://192.168.56.11:8181/restconf/config/network-topology:network-topology/topology/uniconfig/node/IOSXR \
    -H 'content-type: application/json'
```    
    * Create/update/delete of BFD attributes on LAG does not work
    * Create/read/update/delete of ACL does not work properly
    * Create/read/update/delete of SNMP does not work properly

#### Opendaylight Carbon Release Notes
The Frinx controller 3.1.1 is based on OpenDaylight Carbon.

<https://wiki.opendaylight.org/view/Simultaneous_Release/Carbon/Release_Notes>
<https://wiki.opendaylight.org/view/Simultaneous_Release:Carbon_Release_Plan>
<https://wiki.opendaylight.org/view/BGP_LS_PCEP:Carbon_Release_Notes>
