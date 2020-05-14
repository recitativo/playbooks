#!/bin/bash

# show token for kubernetes-dashboard
kubectl -n kubernetes-dashboard describe secrets kubernetes-dashboard-token|tr ' ' '\n'|tail -n 2