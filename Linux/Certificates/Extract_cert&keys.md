# Certificates

## Export certificate and private key from a PFX File

openssl pkcs12 -in certificate.pfx -clcerts -nokeys -out cert.crt

openssl pkcs12 -in certificate.pfx -nocerts -out key.key

openssl rsa -in key.key -out key.pem

## Create a PFX file from certificate and key files

openssl pkcs12 -export -out certificate.pfx -inkey key.key -in certificate.cer
