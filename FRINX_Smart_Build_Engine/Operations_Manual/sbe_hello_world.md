[Documentation main page](https://frinxio.github.io/Frinx-docs/)
[SBE Operations Manual main page](https://frinxio.github.io/Frinx-docs/FRINX_Smart_Build_Engine/operations_manual.html)
# SBE example: Hello world project

This section explains how to mirror the hello-world-samples repository from github to SBE's gerrit and build it in the SBE.

<!-- TOC START min:1 max:3 link:true update:true -->
- [SBE example: Hello world project](#sbe-example-hello-world-project)
    - [Start SBE](#start-sbe)
    - [Enable insecure docker registry](#enable-insecure-docker-registry)
    - [Load base.ldif](#load-baseldif)
    - [Copy Jenkins public key to Gerrit](#copy-jenkins-public-key-to-gerrit)
    - [Set up Nexus repos](#set-up-nexus-repos)
  - [Jenkins configuration](#jenkins-configuration)
    - [Add global environment variables](#add-global-environment-variables)
    - [Configure Docker Plugin](#configure-docker-plugin)
    - [Configure Docker Template](#configure-docker-template)
    - [Generate Jenkins jobs using JobDSL](#generate-jenkins-jobs-using-jobdsl)
- [Troubleshooting](#troubleshooting)

<!-- TOC END -->

### Start SBE

Read [the documentation](sbe_operations_maintenance.md) on how to start the SBE.

### Enable insecure docker registry

To be able to push docker images to Nexus, you need to enable insecure docker registry - Read Deploying a plain HTTP registry [here](https://docs.docker.com/registry/insecure/) and Configuring Docker [here](https://docs.docker.com/engine/admin/).

Open the docker daemon configuration ( /etc/systemd/system/docker.service ), find  
`--insecure-registry nexus.YOUR-SBE-FQDN:8082`.  
Don't forget to replace YOUR-SBE-FQDN.  
Make sure docker host can resolve this domain name e.g. using ping.  
Restart docker.  
Run:

    systemctl daemon-reload
    systemctl restart docker


### Load base.ldif

To import admin user to SBE's LDAP, run

    ./sbe run ldap-import base.ldif  


### Copy Jenkins public key to Gerrit

Prepare your LDAP admin username and password. Unless you changed base.ldiff, run the next line without modifications:

    docker exec sbe-default-jenkins copy-public-key-to-gerrit admin passwd  


### Set up Nexus repos

Prepare your username and password. The first two arguments are credentials to sbe nexus, the latter ones are to frinx. Run

    ./sbe run nexus-create-repos admin admin123 <frinx_username> <frinx_password>   


Verify that the Frinx proxy repository works using

    docker exec sbe-default-jenkins /opt/maven-assets/test_maven.sh nexus.YOUR-SBE-FQDN  


Don't forget to replace YOUR-SBE-FQDN. The command should start downloading artifacts and end with `Test was successful`.

## Jenkins configuration

### Add global environment variables

On the jenkins homepage, click **Manage Jenkins/Configure System** and find the Global Properties section. Check **Environment variables** and add the following two key-value pairs:

    name: `GERRIT_FQDN` , value: `gerrit.YOUR-SBE-FQDN  
    name: `NEXUS_FQDN` , value: `nexus.YOUR-SBE-FQDN  


### Configure Docker Plugin

This step configures the plugin to communicate with a Docker host/daemon. Click **Manage Jenkins/Configure System** to access the main Jenkins settings. At the bottom, there is a dropdown called **Add a new cloud**. Select **Docker** from the list. You can now configure the container options. Set the **name** `docker` The **Docker URL** is where Jenkins launches the agent container. Enter the URL

    unix:///var/run/docker.sock


Use **Test Connection** to verify Jenkins can talk to the Docker Daemon. You should see the Docker version number returned.

### Configure Docker Template

Our plugin can now communicate with Docker. In this step, we'll configure how to launch the Docker Image for the agent.  
Using the Images dropdown, select the **Add Docker Template** dropdown.  
For the **Docker Image**, use `frinx/sbe-jenkins-ssh-slave`  
Click the **Container Settings...** button.  
In the **Network** text box enter `sbe-default`. In the **Volumes** text box enter

    /var/run/docker.sock:/var/run/docker.sock  


Get your Jenkins Slave SSH key (public key of jenkins container). This can be accomplished by running:

    docker exec -it sbe-default-jenkins cat /root/.ssh/id_rsa.pub


You will need it in the next section. Expand the **Environment** textbox with the down arrow. Paste the following lines (the last line will need to be modified):

    --link=sbe-default-gerrit:gerrit  
    --link=sbe-default-nexus:nexus  
    JENKINS_SLAVE_SSH_PUBKEY=  


Make sure you have pasted your ssh key as value of JENKINS_SLAVE_SSH_PUBKEY. It should look similar to this: `JENKINS_SLAVE_SSH_PUBKEY=ssh-rsa ...` To enable builds to specify Docker as a build agent, set a **label** of `docker-agent`.  
Jenkins uses SSH to communicate with agents. Select Credentials `root` from the drop box.

Click Save.

### Generate Jenkins jobs using JobDSL

Navigate to <https://github.com/FRINXio/hello-world-samples/blob/beryllium/development/jobs/README> and follow the instructions there.

After a successful build of the `jobdsl-github` project, you should see a couple of jobs generated in your Jenkins home page. Run

    dsl-hello-world-mirror-from-github  


This project copies the github repo to your gerrit. After that job finishes, jobs building the hello world distribution should start running. Both `dsl-hello-world-beryllium_release` and `dsl-hello-world-beryllium_development` build the hello world distribution. If they succeed, build artifacts including the docker image should be placed in SBE nexus.

# Troubleshooting

**Cannot push docker image**

If you see errors while pushing the docker image, containing message `server gave HTTP response to HTTPS client`, please make sure you have configured docker to use insecure registry as described above.

**localhostname not resolving from the Jenkins container.**

Note that when creating a job from the Jenkins GUI, the repository URL should simply be the SBE component name e.g. gerrit, jenkins, nexus. If you include http the hostname will not resolve.


 [2]: https://github.com/FRINXio/hello-world-samples/blob/beryllium/development/jobs/README
