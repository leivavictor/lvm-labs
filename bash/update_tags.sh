#!/bin/bash
resourcegroup='az-resources'
resources=$(az resource list -g $resourcegroup -o json)  
tag="client=client1"

# Apply tag to resource group
rgid=$(az group show --resource-group $resourcegroup -o json | jq -r '.id')

az resource tag --tags $tag --ids $rgid

# Apply tag to all resources within the resource group
for resource in $(echo "$resources" | jq -c '.[]'); do

    name=$(echo "$resource" | jq -r '.name')
    
    resourcetype=$(echo "$resource" | jq -r '.type')

    if az resource tag --tags $tag -g $resourcegroup -n $name --resource-type $resourcetype --is-incremental; then

        echo "Success"
    else
        echo "Error applying tags to $name"
    fi
 
done