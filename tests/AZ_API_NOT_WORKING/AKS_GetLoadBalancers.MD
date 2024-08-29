# TEST

## Information
Reference: https://learn.microsoft.com/en-us/rest/api/aks/load-balancers/list-by-managed-cluster?view=rest-aks-2024-06-02-preview&tabs=HTTP


SUBSCRIPTION_ID=
RESOURCE_GROUP=
AKS_NAME=
TOKEN=$(az account get-access-token --resource https://management.azure.com/ --query accessToken -o tsv)

curl -X GET https://management.azure.com/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP}/providers/Microsoft.ContainerService/managedClusters/${AKS_NAME}/loadBalancers?api-version=2024-06-02-preview \
-H "Authorization: Bearer $ACCESS_TOKEN"
