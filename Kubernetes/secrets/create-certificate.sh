#!/bin/bash
# Reference: https://kubernetes.github.io/ingress-nginx/user-guide/tls/
kubectl create secret tls ${CERT_NAME} --key ${KEY_FILE} --cert ${CERT_FILE}