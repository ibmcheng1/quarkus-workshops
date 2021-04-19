#!/bin/sh

# command example: <THIS_COMMAND> -n cheng1-test
# oc apply -f ../iac/openshift/ -n quarkus-workshop
# oc apply -f ../iac/openshift/ $@

oc apply -f ../iac/openshift/ $@