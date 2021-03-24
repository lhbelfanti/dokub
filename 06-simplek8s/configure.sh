#! /bin/sh

# Used for the first approach
# kubectl apply -f client-pod.yaml

# Used for hte second approach
kubectl apply -f client-deployment.yaml

# Networking object
kubectl apply -f client-node-port.yaml

kubectl get deployments
kubectl get pods