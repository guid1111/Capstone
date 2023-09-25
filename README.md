# Capstone Project

Current Pipeline Status:   [![CircleCI](https://dl.circleci.com/status-badge/img/gh/guid1111/Capstone/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/guid1111/Capstone/tree/master)



A demonstration project to showcase devops practices centred around a continuous deployment pipeline with the following steps:

    - Lint .NET source code.
    - Build and test .NET source code.
    - Build docker container and upload to the Amazon Web Services Elastic Container Registry.
    - Infrastructure as Code deployment of a Kubenetes cluster to AWS.
    - Rolling deployment of the newly built docker container to the cluster.
    - Smoke test.

The application that is deployed is a very simple ReST style API to calculate the premium of an FX Option.


## Useful Links
>Github repository with project code - [Click Here](https://github.com/guid1111/Capstone)  
Circle CI Build - [Click Here](https://app.circleci.com/pipelines/github/guid1111/Capstone)  

## CICD Pipeline

Note that when looking at the circle CI pipeline, some of the steps described below have been conflated in to single workflow jobs.
The following sections describe the logical operation of the circleCI pipeline defined in ***.circleci/config.yml***, in the order in which they are executed.

### Lint

The C# code is linted using a set of Style Cop rules defined in the file ***OptionPricer/stylecop.ruleset***.
While the code syntax is obviously enforced by the C# compilation step, the Style Cop linter will enforce a certain coding style.  

---

### Build and Test

The C# application code and unit test code is compled.  The application code is in the OptionPricer folder, and the unit test code
is in the OptionPricer.Tests folder.  Once the code has been compiled, the unit tests are run with the results reported the the console.  

---

### Build Docker Image

The docker image for the option prider is built using the configuration ***OptionPricer/Dockerfile***.
The image is built using an microsoft SDK image, but image content just contains the runtime elements required for the OptionPricer rather than 
the full SDK image so that the image created is small.  The docker image is set up so that it will listen on ***port 8000*** for incoming requests.
The image is tagged with the CIRCLE_SHA1 environment variable, meaning a new tag for every build.
The docker image is pushed to the AWS elastic container registry named "capstone".  

---

### Kubenetes cluster deployment using Infrastructure as code

For efficiency the pipeline will test if the cluster is already running, and only create the Kubenetes cluster if it is missing.
For convenience, the cluster is created using the eksctl tool.  However the resulting cloudformation scripts that this uses are 
stored in the "ClusterCLoudFormation" folder in both yml and json formats for inspection.  

The cluster has one node group containing a minimum of 2 nodes and a maximum of 3 nodes, with the cluster configuration described in the *eksctl_cluster_config.yml* file.
There is a further set up that creates a layer 4 load balancer using the ***service-manifest.yml*** file.  The load balancer will listen on port 80 and forward the option pricer application instances
listening on port 8000.  

---

### Application Deployment

Docker contariner deployed to Kubernetes cluster.  
This is done using using the Kubectl utility.  This is a rolling deployment, with container instances being replaced with the newly built and tested image.  

---

### Smoke Test

Once the deployment scripts have run, a smoke test is conducted to ensure successful completion.  This happens by accessing on of the API endpoints and testing for a successful rsponse.


## Other Project Content

***Screenshots***  

These are provided as evidence to meet the project Rubric:

| File    | Evidences |
| -------- | ------- |
| [*ContainerRegistry.png*](Screenshots/ContainerRegistry.png)   | Screenshot showing Docker images stored in Amazon Web Services Elastic Container Registry.  |
| [*LintingFail.png*](Screenshots/LintingFail.png)   | Screenshot showing lint failure due to XXX.  |
| [*LintingSuccess.png*](Screenshots/LintingSuccess.png)   | Screenshot a success with the above problem fixed.  |
| [*DockerBuildAndPush.png*](Screenshots/DockerBuildAndPush.png)   | Screenshot the pipeline docker build and push to the respository.  |
| [*PipelineCluster.png*](Screenshots/PipelineCluster.png)   | Screenshot of the pipeline cluster creation step.  |
| [*CloudFormationCluster.png*](Screenshots/CloudFormationCluster.png)   | Screenshot of the AWS console showing the result of the pipeline creating the cluster.  |
| [*KubeCtlPods.png*](Screenshots/KubeCtlPods.png)   | Screenshot of the AWS console showing the result of the pipeline creating the cluster.  |
| [*KubeCtlServices.png*](Screenshots/KubeCltServices.png)   | Screenshot of the AWS console showing the result of the pipeline creating the cluster.  |
| [*UnitTestSuccess.png*](Screenshots/UnitTestSuccess.png)   | Screenshot of the AWS console showing the result of the pipeline creating the cluster.  |
| [*SmokeTest.png*](Screenshots/SmokeTest.png)   | Screenshot of the AWS console showing the result of the pipeline creating the cluster.  |


---

***Makefile***

A [Makefile](Makefile) is provided for easy local running of various targets including: 

| Target    | Meaing |
| -------- | ------- |
| install  | Install dependencies for local build including the Microsoft SDK.  |
| build | Build the code. |
| test    | Build and test the code. |
| lint    | lint the dockerfile using Hadolint. |
| create-cluster    | Create the kubernetes cluster on AWS. |
| destroy-cluster    | Tear down the kubernetes cluster on AWS. |
| docker-build    | Build the option pricer docker image locally. |
| docker-run-local    | Run the OptionPricer app in the image locally. |
| docker-publish    | Push image to docker hub. |
| kubernetes_run    | Run kubernetes cluster locally (via Docker Desktop). |
| deploy_app_to_cluster    | Deploy docker image stored in AWS to Kubernetes cluster on AWS. |

---
***OptionPricer-local-deploy.yml*** is provided to deploy a locally built docker image to the Kubernetes cluster provided via Docker Desktop.       
