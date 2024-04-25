# Generate an EntraID token to read claims

## User

### Variables

**tenant**= Your azure tenant ID

**client_id**= Your app registration client id

**client_secret**= App registration secret

**username**= Username

**password**= Password

### API call
```bash
curl -X POST \
  "https://login.microsoftonline.com/${tenant}/oauth2/v2.0/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=password&client_id=${client_id}&client_secret=${client_secret}&username=${username}&password=${password}&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default"
```

## SPN

### Variables
**tenant**= Your azure tenant ID

**client_id**= Your app registration client id

**client_secret**= App registration secret

### API Call


```bash
curl -X POST \
  "https://login.microsoftonline.com/${tenant}/oauth2/v2.0/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=client_credentials&client_id=${client_id}&client_secret=${client_secret}&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default"
```