[![CircleCI](https://dl.circleci.com/status-badge/img/gh/guid1111/Capstone/tree/master.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/guid1111/Capstone/tree/master)

# Capstone
Demonstration project to showcase devops practices centred around CICD, Amazon Web Services, Docker and Kubernates


# Udacity Rubric Project Items and their Implementation

## Pipeline
Github repository with project code - [Click Here](https://github.com/guid1111/Capstone)
Docker Image Repository - [docker hub](https://hub.docker.com/repository/docker/guid1111/)

## Docker
Linting in pipeline - linting is carried out by FXCop during the compliation stop of the CICD pipeline.  This can be seen in the .circleci/config.yml target XXX
Dokcer container built in pipeline - A container for the application service is built and uploaded to docker hub as part of the CICD pipeline.

## Deployment
Docker contariner deployed to Kubernetes cluster - The cluster is deployed with CloudFormation or Ansible. This should be in the source code of the student’s submission.

(Deployment vs creation ? - )



Blue/Green or rolling deployment - The project performs the correct steps to do a blue/green or rolling deployment into the environment selected. Submit the following screenshots as evidence of the successful completion of chosen deployment methodology:

    Screenshot of the Circle CI or Jenkins pipeline showing all stages passed successfully.
    Screenshot of your AWS EC2 page showing the newly created (for blue/green) or modified (for rolling) instances running as the EKS cluster nodes.
    Screenshot of the kubectl command output showing that the deployment is successful, pods are running, and the service can be accessed via an external IP or port forwarding.
    Screenshot showing that you can access the application after deployment.

