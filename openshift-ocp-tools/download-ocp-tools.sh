#!/bin/bash

OCP_VERSION=$1
MIRROR=mirror.openshift.com/pub/openshift-v4/clients

wget \
https://${MIRROR}/ocp/${OCP_VERSION}/openshift-install-linux-${OCP_VERSION}.tar.gz

tar zxvf openshift-install-linux-${OCP_VERSION}.tar.gz
rm -f openshift-install-linux-${OCP_VERSION}.tar.gz
chmod +x openshift-install
./openshift-install version

wget \
https://${MIRROR}/ocp/${OCP_VERSION}/openshift-client-linux-${OCP_VERSION}.tar.gz
tar zxvf openshift-client-linux-${OCP_VERSION}.tar.gz 
rm -f openshift-client-linux-${OCP_VERSION}.tar.gz
chmod +x ./oc
./oc version
