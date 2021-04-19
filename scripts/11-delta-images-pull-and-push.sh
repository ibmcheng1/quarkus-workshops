#!/bin/sh

##docker login -u ibmcheng1 -p good44me --tls-verify=false docker.io

# postgresql image
docker pull docker.io/centos/postgresql-96-centos7  

# Delta images
docker pull docker.io/ibmcheng1/cheng1-buildah:latest
docker pull docker.io/ibmcheng1/cheng1-jdk-11-app-runner:latest
docker pull docker.io/ibmcheng1/cheng1-mandrel-builder:latest

# login OpenShift image registry
oc login -u amdin -p admin
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
echo $HOST
docker login -u $(oc whoami) -p $(oc whoami -t) --tls-verify=false $HOST
 
docker tag centos/postgresql-96-centos7:latest $HOST/openshift/postgresql-96-centos7:latest          
docker tag docker.io/ibmcheng1/cheng1-buildah:latest $HOST/openshift/delta-buildah:latest
docker tag docker.io/ibmcheng1/cheng1-jdk-11-app-runner:latest $HOST/openshift/delta-jdk-11-app-runner:latest
docker tag docker.io/ibmcheng1/cheng1-mandrel-builder:latest $HOST/openshift/delta-mandrel-builder:latest

docker push --tls-verify=false $HOST/openshift/postgresql-96-centos7:latest
docker push --tls-verify=false $HOST/openshift/delta-buildah:latest
docker push --tls-verify=false $HOST/openshift/delta-jdk-11-app-runner:latest
docker push --tls-verify=false $HOST/openshift/delta-mandrel-builder:latest







