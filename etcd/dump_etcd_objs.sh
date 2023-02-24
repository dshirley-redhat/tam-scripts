#!/bin/bash

readarray -t ommited_types <ommited-types.txt

cluster_resources=($(printf '%s\n' $(oc api-resources --output=name) |sort))

for ommited_type in "${ommited_types[@]}"; do
    cluster_resources=(${cluster_resources[@]//$ommited_type})
done

for api in "${cluster_resources[@]}"; do 
    if [[ ! " ${ommited_types[*]} " =~ " ${api} " ]]; then
        obj_count=$(oc get $api -A --output name | wc -l)
        echo "$obj_count $api" 
    else
        echo "skipping $api"
    fi 
done