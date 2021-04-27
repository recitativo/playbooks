#!/bin/bash

# show token for kubernetes-dashboard
kubectl -n kubernetes-dashboard get secrets -o=jsonpath='.items[0].data.token}'
