# Velero Lab deployment for AKS

Reference: https://velero.io/docs/v1.1.0/azure-config/

### Pre-requisites:
- AKS Cluster
- An resource group ($AZURE_RESOURCE_GROUP)
- Azure Storage account ($AZURE_STORAGE_ACCOUNT_ID with the name of the resource) with a blob storage for velero ($BLOB_CONTAINER)
- EntraID service principal with a secret to be used by velero ($AZURE_CLIENT_ID  & $AZURE_CLIENT_SECRET)
- The service principal must have access to list storage account keys. This test has been done with "Storage Account Key Operator Service Role" role as it has the minimum priviledge that is needed for the task.

- Download Velero latest release from https://github.com/vmware-tanzu/velero/releases


## Preload required variables
- Complete and execute in shell
    ```bash
    AZURE_SUBSCRIPTION_ID=
    AZURE_TENANT_ID=
    AZURE_CLIENT_ID=
    AZURE_CLIENT_SECRET=
    AZURE_STORAGE_ACCOUNT_ID=
    BLOB_CONTAINER=
    AZURE_BACKUP_RESOURCE_GROUP=
    ```

- Create credentials file for velero installation

    ```bash
    cat << EOF  > ./credentials-velero
    AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}
    AZURE_TENANT_ID=${AZURE_TENANT_ID}
    AZURE_CLIENT_ID=${AZURE_CLIENT_ID}
    AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET}
    AZURE_RESOURCE_GROUP=${AZURE_RESOURCE_GROUP}
    EOF
    ```


- Install velero in the cluster

    ```bash
    ./velero install \
        --provider azure \
        --bucket $BLOB_CONTAINER \
        --plugins velero/velero-plugin-for-microsoft-azure:v1.0.0 \
        --secret-file ./credentials-velero \
        --backup-location-config resourceGroup=$AZURE_BACKUP_RESOURCE_GROUP,storageAccount=$AZURE_STORAGE_ACCOUNT_ID \
        --snapshot-location-config apiTimeout=60min
    ```   

- Delete credentials-velero

    ```bash
    rm ./credentials-velero
    ```

## Create a backup

- Create a backup:
    ```bash
    velero backup create $Backup_name --include-namespaces $Target_namespace
    ```
- Check backup status:

    Logs:
    ```bash
    velero backup logs $Backup_name
    ```

    Describe:
    ```bash
    velero backup describe $Backup_name
    ```
    
    To get information more fast, logs can be exported from Velero pods:
    ```bash
    kubectl logs -l component=velero -n velero
    ```

- Restore a Backup:

    ```bash
    velero restore create $Restore_name --from-backup $Backup_name
    ```