# Prerequisites

## Entra ID:
1. Entra ID Group for every role (E.G DevOps, Cluster Admins, Monitoring, etc) with the users or principals assigned.
    
2. App Registration for the EKS cluster with the following settings:
   1. Allow public client flows -> YES
   2. Group claims enables
   3. Assignment required -> Yes
   4. In enterprise applications view -> Users and groups -> Add groups created in step 1

Values to save from this step:

App registration client id: $EKS_CLUSTER_APP_ID

Entra ID tenant ID: $TENANT_ID

## Implementation
On the EKS Cluster configure an identity provider with the values from the app registration created in step 2 for prerequisites.

Client ID: Client id of the app registration

Group Claims: group

Issuer URL: https://sts.windows.net/${TENANT_ID}/

User Claim: oid (upn can be selected but does not work with service principals)

## Login

### Pre-requisites:

The login is done through kubelogin plugin delivered by Microsoft. Ref: https://github.com/Azure/kubelogin

Variables required:

- EKS Cluster Name: $EKS_NAME
- EKS API URL: $EKS_API
- Download the CA cert of the EKS cluster: $EKS_CERT.crt
- App registration client id: $EKS_CLUSTER_APP_ID
- Entra ID tenant ID: $TENANT_ID


### Steps for User
1. Set the cluster for kubeconfig

```
kubectl config set-cluster $EKS_NAME --server=$EKS_API --certificate-authority=$EKS_CERT
```

2.Generate a user for kubelogin (The name of the user is represented by $USER)

```
kubectl config set-credentials $USER \
  --exec-api-version=client.authentication.k8s.io/v1beta1 \
  --exec-command='kubelogin' \
  --exec-arg='get-token' \
  --exec-arg='--login' \
  --exec-arg='devicecode' \
  --exec-arg='--server-id' \
  --exec-arg='$EKS_CLUSTER_APP_ID' \
  --exec-arg='--client-id' \
  --exec-arg='$EKS_CLUSTER_APP_ID' \
  --exec-arg='--tenant-id' \
  --exec-arg='$TENANT_ID'
```

3. Set the context by using $EKS_NAME and $USER. The context name has been represented as $EKS_CONTEXT_NAME

```
kubectl config set-context $EKS_CONTEXT_NAME --Cluster $EKS_NAME --user $USER

kubectl use-context $EKS_CONTEXT_NAME
```

### Steps for a Service principal

Service principals requires an ClientID and Secret to connect. For this example, we will represent those values as:
AppID: $SPN_CLIENT_ID
Secret: $SPN_CLIENT_SECRET

1. Set the cluster for kubeconfig

```
kubectl config set-cluster $EKS_NAME --server=$EKS_API --certificate-authority=$EKS_CERT
```

2. Save $SPN_CLIENT_SECRET as the environment variable AZURE_CLIENT_SECRET (Used by Kubelogin to perform the authentication)
```
export AZURE_CLIENT_SECRET=$SPN_CLIENT_SECRET
```
2.Generate a user for kubelogin (The name of the SPN user is represented by $SPN_USER)

```
kubectl config set-credentials $SON_USER \
  --exec-api-version=client.authentication.k8s.io/v1beta1 \
  --exec-command='kubelogin' \
  --exec-arg='get-token' \
  --exec-arg='--login' \
  --exec-arg='devicecode' \
  --exec-arg='--server-id' \
  --exec-arg='$EKS_CLUSTER_APP_ID' \
  --exec-arg='--client-id' \
  --exec-arg='$SPN_CLIENT_ID' \
  --exec-arg='--tenant-id' \
  --exec-arg='$TENANT_ID'
```
