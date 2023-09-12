<<Insert CircleCI status Badge>>

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
Docker contariner deployed to Kubernetes cluster
Blue/Green or rolling deployment

