#!/bin/bash
resourcegroup='az-resources'
resources=$(az resource list -g $resourcegroup -o json)  
tag="client=client1"


for resource in $(echo "$resources" | jq -c '.[]'); do

    name=$(echo "$resource" | jq -r '.name')
    
    resourcetype=$(echo "$resource" | jq -r '.type')

    if az resource tag --tags $tag -g $resourcegroup -n $name --resource-type $resourcetype --is-incremental; then

        echo "Success"
    else
        echo "Error applying tags to $name"
    fi
 
done