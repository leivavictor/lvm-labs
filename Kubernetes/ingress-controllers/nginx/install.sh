#!/bin/bash
# Reference: https://docs.nginx.com/nginx-ingress-controller/installation/installing-nic/installation-with-helm/
kubectl create ns ingress

helm install ingress -n ingress oci://ghcr.io/nginxinc/charts/nginx-ingress --version 1.2.0
