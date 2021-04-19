#!/bin/sh

# prereqs:
# 	cp /etc/exports /etc/exports.backup
#   cat "/data       *(rw,sync,no_wdelay,no_root_squash,insecure)" >> /etc/exports
#	exportfs -r
#   showmount -e

WORKING_DIR=${PWD}

SUB='nfs-client-provisioner'
STR=$(oc get pods -n default | grep $SUB)
if [[ "$STR" == *"$SUB"* ]]; then
  	echo "Skip ocp-nfs-storageclass process because it has done before."
  	exit 0
else
	echo "Continue ..." 
fi

echo "-------------------------------------------"
echo "1. Installing helm"
echo "-------------------------------------------"
FILE=/usr/local/bin/helm
if [ -f "$FILE" ]; then
    echo "$FILE exists."
else 
    echo "$FILE does not exist."
    wget https://get.helm.sh/helm-v3.5.4-linux-amd64.tar.gz
    tar -zxvf helm-v3.5.4-linux-amd64.tar.gz
    cp linux-amd64/helm /usr/local/bin/helm    
fi

echo "-------------------------------------------"
echo "2. Installing the Chart on default project"
echo "-------------------------------------------"
#    must update the target NFS server and path

oc project default
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=api.camions.cp.fyre.ibm.com \
    --set nfs.path=/data
    
# Mark a StorageClass (nfs-client) as default:
kubectl patch storageclass nfs-client -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'
kubectl get storageclass

echo "-------------------------------------------"
echo "3. Test NFS storageClass"
echo "-------------------------------------------"
#    need to update the test yaml file to use correct storageclass

yum install git -y
git clone https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner.git
cd nfs-subdir-external-provisioner
sed -i 's/managed-nfs-storage/nfs-client/g' deploy/test-claim.yaml

oc create -f deploy/test-claim.yaml -f deploy/test-pod.yaml

sleep 3
oc get pvc
oc get pv
oc get pods

#Now check your NFS Server for the file SUCCESS.
#oc delete -f deploy/test-pod.yaml -f deploy/test-claim.yaml
    
cd WORKING_DIR
    
echo "----------------------------" 
echo "DONE" 
echo "----------------------------"