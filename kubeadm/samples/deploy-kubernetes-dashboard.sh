#!/bin/bash

# deploy dashboard and dashboard-metrics-scraper
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/deploy/recommended.yaml

# delete dashboard service once
kubectl delete service kubernetes-dashboard -n kubernetes-dashboard

# expose dashboard and dashboard-metrics-scraper via nodeport
kubectl apply -f kubernetes-dashboard-additional.yaml

# add sample crd
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/aio/test-resources/plugin-crd.yml

# show token for kubernetes-dashboard
./get-token.sh