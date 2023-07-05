#!/bin/bash

# Use grep to extract all the URLs from the HTML content, then grep for urls with a version number in it
urls=$(curl -sL "https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/crc/" | grep -o -E 'a href="[^\"]+"' | cut -d'"' -f2 | grep -E '/[0-9]{1}.[0-9]{0,2}' | sort -V)

for url in $urls; do
  version=$(basename "$url")

  openshiftVersion=$(curl -sL "https://mirror.openshift.com/pub/openshift-v4/clients/crc/$version/release-info.json" | jq -r '.version.openshiftVersion')

  echo "Crc Version: $version OpenShift Version: $openshiftVersion"
done