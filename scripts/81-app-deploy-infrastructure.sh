#!/bin/sh

oc new-project quarkus-workshop \
    --description="This is the project for the Quarkus microservices workshop" \
    --display-name="Quarkus Workshop"
 
oc apply -f deploy/OperatorGroup-quarkus-workshop.yaml    
##oc apply -f deploy/CRD-quarkus-workshop.yaml
oc apply -f deploy/CRD-quarkus-workshop-02.yaml
oc apply -f deploy/configmaps.yaml