#!/bin/bash

if [[ $# == 1 ]]; then
    OCP_VERSION=$1
    OUTPUT_FILE=ocp-release-operators.txt
elif [[ $# == 2 ]]; then
    OCP_VERSION=$1
    OUTPUT_FILE=$2
else
    echo "Usage: ./find-release-operator-versions.sh OCP_RELEASE_VERSION <output filename>"
    echo "  Example: ./find-release-operator-versions.sh 4.11 <output filename>"
    echo "  Example: ./find-release-operator-versions.sh 4.8 <output filename>"

    exit -1
fi

echo "" > $OUTPUT_FILE

REDHAT_OPERATORS=registry.redhat.io/redhat/redhat-operator-index:v${OCP_VERSION}
CERTIFIED_OPERATORS=registry.redhat.io/redhat/certified-operator-index:v${OCP_VERSION}
COMMUNITY_OPERATORS=registry.redhat.io/redhat/community-operator-index:v${OCP_VERSION}
REDHAT_MARKETPLACE_OPERATORS=registry.redhat.io/redhat/redhat-marketplace-index:v${OCP_VERSION}

CATALOGS=($REDHAT_OPERATORS $CERTIFIED_OPERATORS $COMMUNITY_OPERATORS $REDHAT_MARKETPLACE_OPERATORS)

#grpcurl -plaintext localhost:50051 describe api.GetBundleInChannelRequest
#grpcurl -plaintext localhost:50051 describe api.Registry.GetBundleForChannel
#grpcurl -plaintext localhost:50051 describe api.ListPackageRequest 

for catalog in ${CATALOGS[@]}; do
    echo "Catalog $catalog" >> $OUTPUT_FILE
    echo "Catalog $catalog"

    podman pull $catalog
    podman run -p50051:50051 \
        --name CATALOG \
        -d \
        "${catalog}" 

    operatorListRaw=$(grpcurl -plaintext  localhost:50051 api.Registry/ListPackages | jq '.name' -r)
    operatorList=$(tr ' ' '\n' <<< "$operatorListRaw" | sort)

    while read -r package_name; do
        echo "package $package_name" >> $OUTPUT_FILE

        package_info=$(grpcurl -plaintext -d '{"name":'\"$package_name\"'}' localhost:50051 api.Registry/GetPackage)
        
        channels=$(echo $package_info | jq .channels[].name -r)
        echo "Available channels:" >> $OUTPUT_FILE

        while read -r channel_name; do
            versions=$(grpcurl -plaintext -d '{"pkgName":'\"$package_name\"',"channelName":'\"$channel_name\"'}' localhost:50051 api.Registry/GetBundleForChannel | jq '.csvName' -r)

            echo "  Channel: $channel_name version: $versions" >> $OUTPUT_FILE
        done <<< $channels

        echo "" >> $OUTPUT_FILE
        :
    done <<< "$operatorList"
    echo "removing old container"
    podman rm -f catalog
done <<< "$CATALOGS"