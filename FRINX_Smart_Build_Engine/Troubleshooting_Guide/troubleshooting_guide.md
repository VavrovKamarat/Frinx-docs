[Documentation main page](https://frinxio.github.io/Frinx-docs/)
[FRINX Smart Build Engine operations manual](https://frinxio.github.io/Frinx-docs/FRINX_Smart_Build_Engine/operations_manual.html)
# SBE: Basic troubleshooting guide

You can use this guide to help you identify and resolve basic problems you may experience with your SBE instance.

Each SBE container has the following pre-installed tools:

    netcat  
    ssh-client  
    ssh-server  
    telnet  
    

**SSH login credentials for apache-ds, sonarqube, nexus, postgresql, redmine and sbe containers:**

username: admin  
password: admin

Example of SSH login into "nexus" component container:

    docker exec -it sbe-default-nexus service ssh start
    ssh admin@<component-ip>
    

Note the SSHd service is not enabled by default for each component
