#!/bin/bash
set -x

ip netns del ns0
ip netns del ns1
#ip link del vpp0
#ip link del vpp1
service vpp restart

sleep 5

#0. setup vms
VHOST_PORT=$(vppctl create vhost socket /tmp/centos_client.sock server)
vppctl set interface l2 bridge $VHOST_PORT 1
vppctl set interface state $VHOST_PORT up

VHOST_PORT_SERVER=$(vppctl create vhost socket /tmp/centos_server.sock server)
vppctl set interface l2 bridge $VHOST_PORT_SERVER 1
vppctl set interface state $VHOST_PORT_SERVER up

#1. setup the first namespace
ip netns add ns0
ip link add vpp0 type veth peer name vethns0
ip link set vethns0 netns ns0
ip netns exec ns0 ip link set lo up
ip netns exec ns0 ip link set vethns0 up
#ip netns exec ns0 ip addr add 2001::1/64 dev vethns0
ip netns exec ns0 ip addr add 10.0.0.11/24 dev vethns0
ip netns exec ns0 ethtool -K vethns0 rx off tx off

ip link set vpp0 up

#2. setup the second namespace
ip netns add ns1
ip link add vpp1 type veth peer name vethns1
ip link set vethns1 netns ns1
ip netns exec ns1 ip link set lo up
ip netns exec ns1 ip link set vethns1 up
#ip netns exec ns1 ip addr add 2001::2/64 dev vethns1
ip netns exec ns1 ip addr add 10.0.0.12/24 dev vethns1
ip netns exec ns1 ethtool -K vethns1 rx off tx off
ip link set vpp1 up

#3. create veth counterparts in vpp
VETH_PORT=$(vppctl create host-interface name vpp0)
VETH_PORT2=$(vppctl create host-interface name vpp1)
vppctl set interface state $VETH_PORT up
vppctl set interface state $VETH_PORT2 up

vppctl show hardware

#4. setup routing/bridging
vppctl set interface l2 bridge $VETH_PORT 1
vppctl set interface l2 bridge $VETH_PORT2 1
#vppctl set interface l2 xconnect $VETH_PORT $VETH_PORT2
#vppctl set interface l2 xconnect $VETH_PORT2 $VETH_PORT
vppctl trace add af-packet-input 8

#5. set up SPAN
#vppctl set int span $VETH_PORT l2 destination $PHYS_PORT
vppctl set int span $VHOST_PORT l2 destination $VETH_PORT
#vppctl set int span $VETH_PORT l2 destination $LOOP_PORT both

#6. verify namespace connection
vppctl clear trace
#vppctl tr add loop0-output 20
#vppctl tr add loop0-tx 20
#vppctl tr add ip4-input 20
vppctl tr add af-packet-input 20
ip netns exec ns0 ping -c 3 10.0.0.12
vppctl sh tr

vppctl sh int