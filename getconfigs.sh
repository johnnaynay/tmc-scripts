#! /bin/bash

# This script automates gathering kubeconfigs for any LCM clusters in TMC #

## variable definitions ##
## LINE is your Cluster Name, defined in clusters.txt

## These variables should be either replaced or defined prior to running. They are not defined in clusters.txt.
## MGMT_CLUSTER is your Management Cluster
## PROVISIONER is your Provisioner
## WORKSPACE is the Workspace Name of the resource
## NAMESPACE is the Namespace for the cluster. This will create the namespace if necessary

while IFS= read -r line; do
  tmc cluster auth kubeconfig get ${LINE} -m ${MGMT_CLUSTER} -p ${PROVISIONER} > ${LINE}.yaml
  tmc cluster namespace create -c ${LINE} -m ${MGMT_CLUSTER} -p ${PROVISIONER} -k ${WORKSPACE} -n ${NAMESPACE}
done < clusters.txt
