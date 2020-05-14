#!/bin/bash

# Before applying, get metrics-server manifest as follow:
# wget https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.6/components.yaml -O metrics-server.yaml
# 
# Then, add followings as `args` into metrics-server-deployment.yaml
#           - --kubelet-insecure-tls
#           - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname

sudo kubectl apply -f metrics-server-yaml
