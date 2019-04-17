
Troubleshooting guide
================================

You can use this guide to help you identify and resolve basic problems you may experience with your SBE instance.

Each SBE container has the following pre-installed tools:

.. code-block:: guess

   netcat  
   ssh-client  
   ssh-server  
   telnet  



**SSH login credentials for apache-ds, sonarqube, nexus, postgresql, redmine and sbe containers:**

username: admin\ :raw-html-m2r:`<br>`
password: admin

Example of SSH login into "nexus" component container:

.. code-block:: guess

   docker exec -it sbe-default-nexus service ssh start
   ssh admin@<component-ip>



Note the SSHd service is not enabled by default for each component
