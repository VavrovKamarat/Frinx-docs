
`Documentation main page <https://frinxio.github.io/Frinx-docs/>`_
`VPP Operations Manual main page <https://frinxio.github.io/Frinx-docs/FRINX_VPP_Distribution/operations_manual.html>`_

General HOW-TO
==============

**Dump VPP message table**

Vpp APIs work with messages, to check all the available messages and their indices use in VAT:

.. code-block:: guess

   dump_msg_api_table



**View VPP node graph**

VPP is implemented as a set of ordered graph nodes, to see them live, use following command in CLI:

.. code-block:: guess

   show vlib graph



**Trace VPP's API executions**

To record the execution of its APIs, use following command outside of VPP:

.. code-block:: guess

   sudo vppctl api trace save demo.api && sudo vppctl api trace custom-dump /tmp/demo.api
