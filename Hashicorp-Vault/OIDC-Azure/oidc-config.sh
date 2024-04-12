#!/bin/bash

# Reference: https://developer.hashicorp.com/vault/docs/auth/jwt/oidc-providers/azuread

# Pre-requisites: Create an EntraID app registration (Steps 1,2,3) and save the AppId
# As it can be seen in user_claim configuration of $oidc_role, the claim for the user is his email.
# During the creation of the app registration, add "email" as an optional claim.
vault_url=http://localhost

export VAULT_ADDR="${vault_url}":8200

vault auth enable oidc

# Define the App Registration information
azure_tenant_id=
oidc_client_id=
oidc_client_secret=
oidc_discovery_url=https://login.microsoftonline.com/${azure_tenant_id}/v2.0

# Define a name for the OIDC Role 
oidc_role=entraid

# Configure OIDC
vault write auth/oidc/config \
         oidc_discovery_url="${oidc_discovery_url}" \
         oidc_client_id="${oidc_client_id}" \
         oidc_client_secret="${oidc_client_secret}" \
         default_role="${oidc_role}" \
         default_lease_ttl=2h \
         max_lease_ttl=2h

ui_callback_url="${vault_url}":8200/ui/vault/auth/oidc/oidc/callback
oidc_callback_url="${vault_url}":8250/oidc/callback

# Configure the role ${oidc_role}
vault write auth/oidc/role/${oidc_role} \
      bound_audiences="${oidc_client_id}" \
      allowed_redirect_uris="${ui_callback_url}" \
      allowed_redirect_uris="${oidc_callback_url}" \
      user_claim="email" \
      token_policies="${oidc_role}" \
      token_ttl=1h \
      token_max_ttl=1h \
      token_explicit_max_ttl=1h \
      token_period=1h 

