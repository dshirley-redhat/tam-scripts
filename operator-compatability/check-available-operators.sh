#!/bin/bash

OCP_VERSION=$1

REDHAT_OPERATORS=registry.redhat.io/redhat/redhat-operator-index:v${OCP_VERSION}
CERTIFIED_OPERATORS=registry.redhat.io/redhat/certified-operator-index:v${OCP_VERSION}
COMMUNITY_OPERATORS=registry.redhat.io/redhat/community-operator-index:v${OCP_VERSION}
REDHAT_MARKETPLACE_OPERATORS=registry.redhat.io/redhat/redhat-marketplace-index:v${OCP_VERSION}


CATALOG=${REDHAT_OPERATORS}

OPERATORS="$(oc mirror list operators --catalog=${CATALOG} | echo "$(cut -d " " -f1 | tail -n +2)")"

while IFS= read -r PACKAGE_NAME; do
    oc mirror list operators --catalog=${CATALOG} --package=${PACKAGE_NAME} && echo ""
done <<< "$OPERATORS"

