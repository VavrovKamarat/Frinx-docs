.. role:: raw-html-m2r(raw)
   :format: html


`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`VPP Operations Manual main page <https://frinxio.github.io/Frinx-docs/FRINX_VPP_Distribution/operations_manual.html>`_
:raw-html-m2r:`<!-- TOC -->`


* `VPP Distribution: Configuring a Span Port on VPP <#vpp-distribution-configuring-a-span-port-on-vpp>`_

  * `Install epel-release <#install-epel-release>`_
  * `Install virtualization packages <#install-virtualization-packages>`_
  * `Update QEMU to 2.9.0 <#update-qemu-to-290>`_
  * `Update packages and install other tools <#update-packages-and-install-other-tools>`_
  * `Install VPP <#install-vpp>`_
  * `Set selinux to permissive <#set-selinux-to-permissive>`_
  * `Reboot the host to apply changes and boot with updated kernel <#reboot-the-host-to-apply-changes-and-boot-with-updated-kernel>`_
  * `Run VPP script <#run-vpp-script>`_
  * `Prepare client VM <#prepare-client-vm>`_
  * `Prepare server VM <#prepare-server-vm>`_
  * `Run some traffic <#run-some-traffic>`_
  * `VPP CLIs for SPAN feature <#vpp-clis-for-span-feature>`_

:raw-html-m2r:`<!-- /TOC -->`

Configuring a Span Port on VPP
==============================

This guide assumes a freshly installed system with CentOS-7-x86_64-Minimal-1708.iso. 
You can access it `here <http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso>`_ - choose your own mirror.

Install epel-release
--------------------

.. code-block:: guess

   yum install epel-release -y

Install virtualization packages
-------------------------------

.. code-block:: guess

   yum group install "Virtualization Host" –y
   yum install virt-manager libvirt libvirt-python python-virtinst libvirt-client –y

Update QEMU to 2.9.0
--------------------


#. Install: 
   .. code-block:: guess

      yum -y install http://mirror.centos.org/centos/7/virt/x86_64/kVM-common/qemu-img-ev-2.9.0-16.el7_4.13.1.x86_64.rpm http://mirror.centos.org/centos/7/virt/x86_64/kVM-common/qemu-kVM-common-ev-2.9.0-16.el7_4.13.1.x86_64.rpm http://mirror.centos.org/centos/7/virt/x86_64/kVM-common/qemu-kVM-ev-2.9.0-16.el7_4.13.1.x86_64.rpm http://mirror.centos.org/centos/7/virt/x86_64/kVM-common/qemu-kVM-tools-ev-2.9.0-16.el7_4.13.1.x86_64.rpm

#. Configure: We need to configure qemu to run as root in ``/etc/libvirt/qemu.conf``\ : 

   * Find the lines *#user = "root"* and *#group = "root"* and uncomment them.

Update packages and install other tools
---------------------------------------

.. code-block:: guess

   yum –y update
   yum -y install vim #optional

Install VPP
-----------


#. First we need to set up the fdio repository: 
   .. code-block:: guess

      cat >> /etc/yum.repos.d/fdio-stable1801.repo << EOF [fdio-1801] name=fd.io stable 1801 branch latest merge baseurl=https://nexus.fd.io/content/repositories/fd.io.stable.1801.centos7/ enabled=1 gpgcheck=0 EOF

#. 
   .. code-block:: guess

      yum -y install vpp vpp-lib vpp-plugins vpp-api-python

#. 
   .. code-block:: guess

      service vpp start

#. Optional: you can setup vpp to start on boot: 
   .. code-block:: guess

      chkconfig vpp on

#. Verify that HugePages are set up: 
   .. code-block:: guess

      grep HugePages /proc/meminfo


* HugePages_Total should be 1024, if it isn’t, reboot and start VPP after reboot

Set selinux to permissive
-------------------------


#. Enter the following:
   .. code-block:: guess

      setenforce 0

#. Make the config persistent in ``/etc/selinux/config``

Reboot the host to apply changes and boot with updated kernel
-------------------------------------------------------------

.. code-block:: guess

   reboot

Run VPP script
--------------


#. VPP must be running
#. Enter the following:
   .. code-block:: guess

      chmod 755 tap_monitoring.sh

#. 
   .. code-block:: guess

      ./tap_monitoring.sh
   The script will create vhost-user interfaces for VMs and also create two Linux namespaces with veth ports with one end in Linux and the other in VPP. All of these are in a bridge domain in VPP. The port mirroring is set up from centos_client’s vhost to ns0’s veth interface.

Prepare client VM
-----------------


#. Create disk for the VM: (Substitute 5G for a disk with the size of your choosing)
   .. code-block:: guess

      qemu-img create -f qcow2 /var/lib/libvirt/images/centos-client.img 5G

#. Download the Centos image mentioned above to ``/var/lib/libvirt/images/``\ : (you can change the following URL to a mirror that’s closer to you)
   .. code-block:: guess

      wget -P /var/lib/libvirt/images/ http://ftp.upjs.sk/pub/centos/7/isos/x86_64/CentOS-7-x86_64-Minimal-1708.iso

#. Create Vhost user socket in VPP:
   .. code-block:: guess

      vppctl create vhost socket /tmp/centos_client.sock server

#. The VM accepts VNC connections on port 5900, but we need to configure the firewall to allow connection to VNC ports: 
   .. code-block:: guess

      firewall-cmd --permanent --zone=public --add-port=5900-5901/tcp firewall-cmd –reload

#. Make sure you have a VNC client installed before starting the VM
#. Start the VM (Click `here <centos_client.xml>`_ to access the centos_client.xml file)
   .. code-block:: guess

      virsh define centos_client.xml
      virsh start centos_client

#. Connect to the VNC server running on the host:
    &lt;host-ip&gt;:5900
#. Install the operating system

   * Make sure you configure the network to use the non-vhost interface (its mac should start with  52:54:00).


* Also ensure you configure a root password.


#. After the VM reboots, log in with user root and the password you set up
#. Bring the non-vhost interface 
   .. code-block:: guess

      up ifup ens6

#. Connect to the on ens6 from the host
#. Modify the ``/etc/sysconfig/network-scripts/ifcfg-ens6`` script by changing ONBOOT to yes
#. Configure the vhost port:
   .. code-block:: guess

      cat > /etc/sysconfig/network-scripts/ifcfg-eth0 << EOF TYPE=Ethernet PROXY_METHOD=none BROWSER_ONLY=no BOOTPROTO=static DEFROUTE=yes IPV4_FAILURE_FATAL=no NM_CONTROLLED=no NAME=eth0 UUID=b8f1a263-9495-43db-9ef1-0393225e4faf DEVICE=eth0 ONBOOT=yes IPADDR=10.0.0.21 NETMASK=255.255.255.0 GATEWAY=10.0.0.1 EOF

#. Make sure that the interface names correspond with the script filenames
#. Enable the vhost-user interface 
   .. code-block:: guess

      ifup eth0

#. Install Iperf3 
   .. code-block:: guess

      yum -y install iperf3

#. Disable firewall 
   .. code-block:: guess

      service firewalld stop 
      chkconfig firewalld off

Prepare server VM
-----------------

We don’t have to go through the whole installation process, because we can just copy the disk and change the IP of the vhost-user port:


#. Enter the following:
   .. code-block:: guess

      cp /var/lib/libvirt/images/centos-client.img /var/lib/libvirt/images/centos-server.img

#. (Click `here <centos_server.xml>`_ to access the centos_server.xml file)
   .. code-block:: guess

      virsh define centos_server.xml 
      virsh start centos_server

#. The VM will have a different IP on the management port, look in the arp tables for it: 
   .. code-block:: guess

      arp –a ? (192.168.122.118) at 52:54:00:c2:13:f9 [ether] on virbr0

#. Change the IP in ``/etc/sysconfig/network-scripts/ifcfg-eth0`` to 10.0.0.22
#. Apply the changes: 
   .. code-block:: guess

      ifdown eth0 && ifup eth0

Run some traffic
----------------

When both VMs are running we just need to set up Iperf:


#. On the server VM: 
   .. code-block:: guess

      iperf –s

#. On the client VM: 
   .. code-block:: guess

      iperf –c 10.0.0.22

#. This will sent packets from client VM to server VM through VPP. VPP will mirror packet from client’s vhost-user interface (vpp0 in linux)
#. Various statistics can be gathered from ``/sys/class/net/vpp0/statistics/``\ , or you can use the script collect_stats.pl (\ `click here <collect_stats.pl>`_ to access): 
   .. code-block:: guess

      chmod 755 collect_stats.pl ./collect_stats.pl

VPP CLIs for SPAN feature
-------------------------

You can investigate the tap_monitoring.sh script `click here to download <tap_monitoring.sh>`_ to see which VPP clis were used. There are a few in particular which are unique to this usecase:

.. code-block:: guess

   vppctl set int span <source interface name> l2 destination <destination interface name>
   vppctl show int #shows interface names and counters
   vppctl show int span #shows the interfaces on which the SPAN feature is configured

The SPAN feature is certainly usable on interfaces in l2 mode (the scripts sets all interfaces to be in a bridge domain).
