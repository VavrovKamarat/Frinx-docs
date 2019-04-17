
Project Definition
==================


.. raw:: html

   <!-- TOC START min:1 max:3 link:true update:true -->
   - [SBE Project Definition](#sbe-project-definition)
     - [Project definition YAML document example](#project-definition-yaml-document-example)

   <!-- TOC END -->



The build project has its project definition as one yaml file in the "projects/" folder. Projects which you will build using the SBE have a definition file (yaml document). Such a yaml file is required for each project.

SBE project definition file e.g.: sbe/projects/hello-world-samples.yaml

Project definition YAML document example
----------------------------------------

.. code-block:: guess

   description: "Hello World Samples - SNAPSHOT"

   template: "maven-build"  
   concurrentBuild: true  
   disabled: false

   source: name: "hello-world-samples"  
   branch: "master"

   shell: | mvn clean deploy sonar:sonar -DskipTests -DaltDeploymentRepository="snapshot::default::http://nexus:8081/repository/local-snapshots" -Dsonar.host.url=http://sonarqube:9000



**Document items description**

description -> **Job description in Jenkins** :raw-html-m2r:`<br>`
template -> **Predefined XML template in Jenkins container, which have all options for job creation by Jenkins.** :raw-html-m2r:`<br>`
concurrentBuild -> **Boolean value (concurent build disabled)** :raw-html-m2r:`<br>`
disabled - > **Boolean value (job disabled)**

source:name: -> **Define project name in Gerrit (from where take Jenkins sources)** :raw-html-m2r:`<br>`
source:branch -> **Define project branch in Gerrit (checkout custom branch in project)**

shell:| -> **User defined shell code**

.. code-block:: guess

   shell: | mvn clean deploy -DaltDeploymentRepository="snapshot::default::http://nexus:8081/repository/local-snapshots"



This is the default deploy configuration, which uploads project artifacts into the SBE Nexus; for deploying artifacts into the Frinx Artifactory just replace the deploy option:

.. code-block:: guess

   shell: | mvn clean deploy -DaltDeploymentRepository="artifactory::default::https://artifactory.frinx.io/artifactory/sb-snapshots"



The SBE has all the necessary credentials for uploading to the Frinx Artifactory store.
