#!/bin/bash

getCrcOcpVersion(){
    version=$1
    response=$(curl -sL "https://mirror.openshift.com/pub/openshift-v4/clients/crc/$version/release-info.json")
    openshiftVersion=$(echo "$response" | jq -r '.version.openshiftVersion')

    echo "Crc Version: $version OpenShift Version: $openshiftVersion"
}

response=$(curl -sL "https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/crc/")

# Use grep to extract all the URLs from the HTML content, then grep for urls with a version number in it
urls=$(echo "$response" | grep -o -E 'a href="[^\"]+"' | cut -d'"' -f2 | grep -E '/[0-9]{1}.[0-9]{0,2}')

for url in $urls; do
  last_segment=$(basename "$url")

  getCrcOcpVersion $last_segment
done