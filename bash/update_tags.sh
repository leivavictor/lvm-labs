#!/bin/bash
resourcegroup='rg'
resources=$(az resource list -g $resourcegroup -o json)  
tag="Client=clientx"

# Apply tag to resource group
rgid=$(az group show --resource-group $resourcegroup -o json | jq -r '.id')

az resource tag --tags $tag --ids $rgid --is-incremental

# Apply tag to all resources within the resource group
for resource in $(echo "$resources" | jq -c '.[]'); do

    id=$(echo "$resource" | jq -r '.id')
    
    echo "$id"

    if az resource tag --tags $tag --ids $id --is-incremental; then

        echo "Success"
    else
        echo "Error applying tags to $id"
    fi
 
done