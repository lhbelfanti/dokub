# Simple Kubernetes App

Starting with Kubernetes (k8s). 

Simple application that creates a Kubernetes cluster and deploys an image (hosted in Docker HUB) previously created in the [complex application](../05-complex/README.md) of the last section.

It uses 2 configuration files: [client-pod.yaml](./client-pod.yaml) and [client-node-port.yaml](./client-node-port.yaml).

To run both of them execute the [configure.sh](./configure.sh):

`sh configure.sh`

There is a 3rd configuration file [client-deployment.yaml](./client-deployment.yaml) that is used to create a Deployment Kubernetes' object instead of a Pod Kubernetes' object (created by the client-pod.yaml).