#!/bin/sh

# Pre-condition:
#   Optional initial OCP setup via OCP web console
#   login to web console and add httpd file to oAuth
#       Administration > Global Configuration > OAuth > Identity Providers
#               Add  HTPasswd
#
# Ensure you are in the workspace directory, e.g. "/opt/cp4auto".
#

SUB='htpass-secret'
STR=$(oc get secret -n openshift-config | grep $SUB)
if [[ "$STR" == *"$SUB"* ]]; then
  	echo "Skip ocp-init-setup process because it has done before."
  	exit 0
else
	echo "Continue ..." 
fi

HTPASSWD_FILE=ocp.oauth.users.htpasswd/users.htpasswd
OAUTH_htpasswd_FILE=ocp.oauth.users.htpasswd/OAuth-htpasswd.yaml

oc login -u system:admin

echo "-------------------------------------------"
echo "1. Add users to OCP with htpasswd"
echo "-------------------------------------------"

oc create secret generic htpass-secret --from-file=htpasswd=${HTPASSWD_FILE} -n openshift-config
oc apply -f $OAUTH_htpasswd_FILE
sleep 3 
    
echo "-------------------------------------------"
echo "2. Grant cluster-admin role to admin"
echo "-------------------------------------------"
oc adm policy add-cluster-role-to-user cluster-admin admin

echo "-------------------------------------------"
echo "3. Create default OCP 4 image registry route"
echo "-------------------------------------------"
oc patch configs.imageregistry.operator.openshift.io/cluster --patch '{"spec":{"defaultRoute":true}}' --type=merge
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
echo $HOST