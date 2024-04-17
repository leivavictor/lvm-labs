
openssl pkcs12 -in certificate.pfx -clcerts -nokeys -out cert.crt

openssl pkcs12 -in certificate.pfx -nocerts -out key.key

openssl rsa -in key.key -out key.pem